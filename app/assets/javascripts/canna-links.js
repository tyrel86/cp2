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
	function linkOffStatic(object) {
		var checkReg = /hover/
		var oldSrc = object.src
		if( checkReg.test(oldSrc) ) {
			var newSrc = oldSrc.slice( 0, ( oldSrc.length - 10 ) ) + ".png"
			object.src = newSrc	
		}
	}
	function linkMouseDown() {
		linkOffStatic($(this))
		var checkReg = /click/
		var oldSrc = this.src
		if(! checkReg.test(oldSrc) ) {
			var newSrc = oldSrc.slice( 0, ( oldSrc.length - 4 ) ) + "-hover.png"
			this.src = newSrc
		}
	}

	function linkMouseUp() {
		var checkReg = /click/
		var oldSrc = this.src
		if( checkReg.test(oldSrc) ) {
			var newSrc = oldSrc.slice( 0, ( oldSrc.length - 10 ) ) + ".png"
			this.src = newSrc	
		}
	}

	

	$('.canna-link').hover( linkOn, linkOff )
  $('#cat-select').hover( linkMouseDown, linkMouseUp )
	
	function changeCategory(){
		var value = this.children[0].innerHTML
		$('#send-cat')[0].value = value
		$('#cat-text-value').html(value)
	}

	$('.cat-select-btn').click( changeCategory )

})
