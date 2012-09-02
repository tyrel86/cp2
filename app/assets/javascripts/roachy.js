/* Roachy javascript engine */

var setRoachyAsActive = function( roachy ) {
	var currentRoachy = getCurrentRoachy()
	setRoachyAsInactive( currentRoachy )
	roachy.removeClass( 'roachy-inactive' )
	roachy.addClass( 'roachy-active' )
}

var setRoachyAsInactive = function( roachy ) {
	roachy.removeClass( 'roachy-active' )
	roachy.addClass( 'roachy-inactive' )
}

var getCurrentRoachy = function() {
	return $('.roachy-active')
}

var getRoachyByIndex = function( index ) {
	search_string = "#roachy-lesson-" + index
	return $( search_string ).first()
}

var getNextRoachy = function() {
	var current_roachy = getCurrentRoachy()
	current_index = getRoachyIndex( current_roachy )
	next_index = incr_roachy_index( current_index )
	return getRoachyByIndex( next_index )
}

var incr_roachy_index = function( index ) {
	if( index < get_num_of_roachys() ) {
		return_val = index + 1
	} else {
		return_val = 1
	}
	return return_val
}

var decr_roachy_index = function( index ) {
	if( index > 1 ) {
		return_val = index - 1
	} else {
		return_val = get_num_of_roachys
	}
	return return_val
}

var get_num_of_roachys = function() {
	return $('.roachy-text').size()
}

var getPreviousRoachy = function() {
	var current_roachy = getCurrentRoachy()
	current_index = getRoachyIndex( current_roachy )
	next_index = decr_roachy_index( current_index )
	return getRoachyByIndex( next_index )
}

var getRoachyIndex = function( roachy ) {
	return parseInt( roachy.attr( 'id' ).split('-')[2] )
}

$(document).ready( function() {
	
	$('#roachy-btn-previous').click( function() {
		setRoachyAsActive( getPreviousRoachy() )
	})

	$('#roachy-btn-next').click( function() {
		setRoachyAsActive( getNextRoachy() )
	})

	$('#roachy-btn-index').click( function() {
		alert( 'list all' )
	})

	$('#roachy-btn-hit').click( function() {
		alert( 'puff puff' )
	})

})
