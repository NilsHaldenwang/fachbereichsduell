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

}