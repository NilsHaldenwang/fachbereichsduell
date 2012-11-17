var perform_reload_check_and_reload_if_necessary = function() {
	$.getJSON('/questions/reload_check', function (data) {
		if(data.reload) {
			window.location = '/questions/show';
		}
	});
};

var enable_reload_check = function() {
	$(function() { setInterval(perform_reload_check_and_reload_if_necessary, 3 * 1000); });
};
