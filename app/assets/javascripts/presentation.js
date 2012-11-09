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

  wait_interval = 80;
  wait_time = 0;

  new_text = answer_text;
  number_of_point_groups_left = 15 - new_text.length;

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

  wait_time = wait_time + wait_interval;

  setTimeout(function(){
    $("#points-answer-" + answer_id).text(answer_points);
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
      });
    }
  });
};

var observe_points_and_xes = function(){
  $.getJSON('points_and_xes', function(data){
    $("#team_1_points_and_xes").text(data.team_1_points_and_xes);
    $("#team_2_points_and_xes").text(data.team_2_points_and_xes);
  });
};

var observe_round = function(){
  $.getJSON('round', function(data){
    $("#round-nr").text(data.round);
  });
};

$(function(){
  setInterval(observe_view_state, 1000);
  setInterval(observe_points_and_xes, 1000);
  setInterval(observe_round, 1000);
});

var observe_answer_state = function(answer_id) {
  $.getJSON('answer_state/' + answer_id, function(data){
    if(data.visible){
      animate_answer_replacement(answer_id, data.content, data.normalized_points);
      eval("clearInterval(answer_timer_" + answer_id + ");");
    }
  });
};
