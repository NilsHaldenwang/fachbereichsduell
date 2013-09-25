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
        observe_points();
        observe_round();

      });
    }
  });
};

var observe_points = function(){
  $.getJSON('points', function(data){
    $("#team_1_points").text(data.team_1_points);
    $("#team_2_points").text(data.team_2_points);
  });
};

var observe_round = function(){
  $.getJSON('round', function(data){
    $("#round-nr").text(data.round);
  });
};

$(function(){
  setInterval(observe_view_state, 1000);
});
