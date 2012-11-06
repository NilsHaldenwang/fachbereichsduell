class QuestionsController < ApplicationController

  def show
    @game_state = GameState.instance

    if @game_state.showing_question?
      @question = @game_state.current_question

      if @question.choices?
        render 'choices'
      elsif @question.estimation?
        render 'estimation'
      end
    else
      render 'please_wait'
    end
  end

  def reload_check
    @game_state = GameState.instance

    reload = nil
    if @game_state.showing_question?
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
      

      if @question.question_type == Question::QUESTION_TYPE_CHOICES

      elsif @question.question_type == Question::QUESTION_TYPE_ESTIMATION
        @answer = EstimationAnswer.create({value: params[:value].gsub(",","."), question: @question})
        if @answer.valid?
          #eingeloggt
          @given_answer = @answer.value
          render 'answer_saved'
        else
          #ging nicht (ggf. invalid value)
          render text: "ging nicht"
        end
      end

    else
      #zu spät
      render text: "zu spaet"
    end


    


  end

end
