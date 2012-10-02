$(document).ready( function() {
	$('#radius-change').blur( function() {
		$('#send-radius').attr( 'value', $(this).attr('value') );
	})
})
