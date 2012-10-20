window.onload = function() {
    var arrInputs = document.getElementsByTagName("input");
    for (var i = 0; i < arrInputs.length; i++) {
        var curInput = arrInputs[i];
        if (!curInput.type || curInput.type == "" || curInput.type == "text")
            HandlePlaceholder(curInput);
    }
};

function HandlePlaceholder(oTextbox) {
    if (typeof oTextbox.placeholder == "undefined") {
        var curPlaceholder = oTextbox.getAttribute("placeholder");
        if (curPlaceholder && curPlaceholder.length > 0) {
            oTextbox.value = curPlaceholder;
            oTextbox.setAttribute("old_color", oTextbox.style.color);
            oTextbox.style.color = "#c0c0c0";
            oTextbox.onfocus = function() {
                this.style.color = this.getAttribute("old_color");
                if (this.value === curPlaceholder)
                    this.value = "";
            };
            oTextbox.onblur = function() {
                if (this.value === "") {
                    this.style.color = "#c0c0c0";
                    this.value = curPlaceholder;
                }
            };
        }
    }
}

$(document).ready( function() {
	$('#radius-change').blur( function() {
		$('#send-radius').attr( 'value', $(this).attr('value') );
	})
	$('#radius-input').keyup( function(e) { 
		if(e.keyCode == 13) { 
			$('#cannaenginetext-big').focus();
			$(".main-find-btn").click(); 
		} 
	});
	$('.main-find-btn').click( function() {
		$('form.form-search').submit()
	})
})
