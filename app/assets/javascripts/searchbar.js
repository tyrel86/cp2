$(document).ready( function() {
	$('#radius-change').blur( function() {
		$('#send-radius').attr( 'value', $(this).attr('value') );
	})
	$('#radius-input').keyup( function(e) { 
		if(e.keyCode == 13) { 
			$('#cannaenginetext-big').focus();
			$("#main-find-btn").click(); 
		} 
	});
})
