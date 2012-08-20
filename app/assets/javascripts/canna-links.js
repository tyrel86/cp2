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
})
