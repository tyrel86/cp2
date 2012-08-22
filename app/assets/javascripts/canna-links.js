$(document).ready( function() {

	function linkOn() {
		var checkReg = /hover/
		var oldSrc = this.src
		if(! checkReg.test(oldSrc) ) {
			var newSrc = oldSrc.slice( 0, ( oldSrc.length - 4 ) ) + "-hover.png"
			this.src = newSrc
		}
	}

	function linkOff() {
		var checkReg = /hover/
		var oldSrc = this.src
		if( checkReg.test(oldSrc) ) {
			var newSrc = oldSrc.slice( 0, ( oldSrc.length - 10 ) ) + ".png"
			this.src = newSrc	
		}
	}

	$('.canna-link').hover( linkOn, linkOff )
  $('#cat-select').hover( linkOn, linkOff )
	
	function changeCategory(){
		var value = this.children[0].innerHTML
		$('#send-cat')[0].value = value
		$('#cat-text-value').html(value)
	}

	$('.cat-select-btn').click( changeCategory )

})
