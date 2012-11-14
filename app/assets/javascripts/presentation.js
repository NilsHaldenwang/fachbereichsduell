var replace_next_dots_with_string = function(text, replace_string) {

  pattern = /\.\.\./;
  position = text.search(pattern);
  if(position >= 0) {
    before_dots = text.substr(0, position);
    after_dots = text.substr(position + 3);
    return before_dots + replace_string + after_dots;
  }
  else {
    //not found
    return text + replace_string;
  }

};

var animate_answer_replacement = function(answer_id, answer_text, answer_points){

  if(eval("answer_busy_" + answer_id + " === true")) {
    //early return trolololol
    return;
  }

  //make answer busy and never unbusy again
  eval("answer_busy_" + answer_id + " = true;");

  wait_interval = 40;
  wait_time = 0;

  new_text = answer_text;
  number_of_point_groups_left = 20 - new_text.length;

  $("#answer_audio").get(0).volume = 1;
  $("#answer_audio").get(0).play();

  $.map(new_text.split(''), function(str){
    wait_time = wait_time + wait_interval;

    setTimeout(function(){
      $("#answer-" + answer_id).text(replace_next_dots_with_string($("#answer-" + answer_id).text(), str));
    }, wait_time);

  });

  for( i = 0; i < number_of_point_groups_left; i++){
    wait_time = wait_time + wait_interval;
    setTimeout(function(){
      $("#answer-" + answer_id).text(replace_next_dots_with_string($("#answer-" + answer_id).text(), ''));
    }, wait_time);
  }

  wait_time = wait_time +  500;

  setTimeout(function(){
    $("#points_audio").get(0).volume = 1;
    $("#points_audio").get(0).play();

    $("#points-answer-" + answer_id).text(answer_points);

    //query points after answer has been revealed
    observe_points_and_xes();

  }, wait_time);

};

var current_state = "";

var observe_view_state = function(){
  $.getJSON('view_state', function (data) {
    if(data.view_state !== current_state) {
      current_state = data.view_state;

      $.ajax({
        url: current_state
      }).done(function(html){
        $("#ajax-container").html(html);

        //change round if needed and update points
        observe_points_and_xes();
        observe_round();

      });
    }
  });
};

var observe_points_and_xes = function(){
  $.getJSON('points_and_xes', function(data){

    play_sound = false;

    first_x_idx_t_1 = $("#team_1_points_and_xes").text().search('X');

    if(first_x_idx_t_1 > 0){

      team_1_x_length = $("#team_1_points_and_xes").text().substr(first_x_idx_t_1).length;

      if(team_1_x_length < data.team_1_x.length){
        play_sound = true;
      }
    } else if(first_x_idx_t_1 === -1 && data.team_1_x.length > 0) {
      play_sound = true;
    }

    first_x_idx_t_2 = $("#team_2_points_and_xes").text().search(' ');

    if(first_x_idx_t_2 > 0){

      team_2_x_length = $("#team_2_points_and_xes").text().substr(0, first_x_idx_t_2).length;

      if(team_2_x_length < data.team_2_x.length){
        play_sound = true;
      }
    } else if(first_x_idx_t_2 === 0 && data.team_2_x.length > 0){
      play_sound = true;
    }

    if(play_sound){
      $("#zonk_audio").get(0).volume = 1;
      $("#zonk_audio").get(0).play();
    }

    $("#team_1_points_and_xes").text("" + data.team_1_points + " " + data.team_1_x);
    $("#team_2_points_and_xes").text("" + data.team_2_x + " " + data.team_2_points);
  });
};

var observe_xes = function(){
  $.getJSON('points_and_xes', function(data){

    play_sound = false;

    first_x_idx_t_1 = $("#team_1_points_and_xes").text().search('X');

    if(first_x_idx_t_1 > 0){

      team_1_x_length = $("#team_1_points_and_xes").text().substr(first_x_idx_t_1).length;

      if(team_1_x_length < data.team_1_x.length){
        play_sound = true;
      }
    } else if(first_x_idx_t_1 === -1 && data.team_1_x.length > 0) {
      play_sound = true;
    }

    first_x_idx_t_2 = $("#team_2_points_and_xes").text().search(' ');

    if(first_x_idx_t_2 > 0){

      team_2_x_length = $("#team_2_points_and_xes").text().substr(0, first_x_idx_t_2).length;

      if(team_2_x_length < data.team_2_x.length){
        play_sound = true;
      }
    } else if(first_x_idx_t_2 === 0 && data.team_2_x.length > 0){
      play_sound = true;
    }

    if(play_sound){
      $("#zonk_audio").get(0).volume = 1;
      $("#zonk_audio").get(0).play();

      $("#team_1_points_and_xes").text("" + data.team_1_points + " " + data.team_1_x);
      $("#team_2_points_and_xes").text("" + data.team_2_x + " " + data.team_2_points);
    }
  });
};

var observe_round = function(){
  $.getJSON('round', function(data){
    $("#round-nr").text(data.round);
  });
};

var observe_answer_state = function(answer_id) {

    $.ajax({
      url: 'answer_state/' + answer_id,
      dataType: "json",
      success: function(data){
        if(data.visible){
          animate_answer_replacement(answer_id, data.content, data.normalized_points);
          eval("clearInterval(answer_timer_" + answer_id + ");");
        }
      }
    });

};

$(function(){
  setInterval(observe_view_state, 1000);
  //don't query all the time
  //setInterval(observe_points_and_xes, 1000);
  //setInterval(observe_round, 1000);
  setInterval(observe_xes, 1000);

  $("#answer_audio").get(0).volume = 0;
  $("#answer_audio").get(0).play();

  $("#points_audio").get(0).volume = 0;
  $("#points_audio").get(0).play();

  $("#zonk_audio").get(0).volume = 0;
  $("#zonk_audio").get(0).play();
});
