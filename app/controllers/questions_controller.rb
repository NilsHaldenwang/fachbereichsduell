class QuestionsController < ApplicationController

  def show
    @game_state = GameState.instance

    if @game_state.showing_question?
      @question = @game_state.current_question

      unless @question.was_answered_by?(request.remote_ip)

        if @question.choices?
         render 'choices'
        elsif @question.estimation?
         render 'estimation'
        end

      else
        #question already answered
        render 'answer_already_answered'
      end
    else
      render 'please_wait'
    end
  end

  def reload_check
    @game_state = GameState.instance

    reload = nil
    if @game_state.showing_question? && !@game_state.current_question.was_answered_by?(request.remote_ip)
      reload = true
    end
    
    render json: {reload: reload}.to_json
  end

  def submit_answer
    @game_state = GameState.instance

    if @game_state.showing_question?
      #die antwort wird noch akzeptiert
      @question = @game_state.current_question
      
      #todo: pruefen ob der fragende die frage bereits beantwortet hat
      unless @question.was_answered_by?(request.remote_ip)

        if @question.question_type == Question::QUESTION_TYPE_CHOICES
          #find correct answer
          chosen_answer = TextAnswer.find(params[:answer_id])
          if !chosen_answer
            #render error
            #todo
            flash[:error] = "Die Antwort konnte leider nicht verarbeitet werden."
            redirect_to :show
          else
            #atomically increment count
            chosen_answer.class.update_all("count = (count + 1)", "id = #{chosen_answer.id}")
            #we assume that this did work
            @given_answer = chosen_answer.content
            render 'answer_saved'
          end
        elsif @question.question_type == Question::QUESTION_TYPE_ESTIMATION
          @answer = EstimationAnswer.create({value: params[:value].gsub(",","."), question: @question})
          if @answer.valid?
            #eingeloggt
            @given_answer = @answer.value
            #note that user answered
            @question.was_answered_by!(request.remote_ip)
          
            render 'answer_saved'
          else
            #ging nicht (ggf. invalid value)
            #todo
            flash[:error] = "Die Antwort #{@answer.value} konnte leider nicht verarbeitet werden."
            redirect_to :show
          end
        end

      else
      #schon geantwortet
      render 'answer_already_answered' 
      end
    else
      #zu spät
      render 'answer_too_late'
    end
  end

end
