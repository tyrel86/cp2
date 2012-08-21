$(document).ready ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  $('.alert').alert()
  $('.dropdown-toggle').dropdown()
  $(".collapse").collapse()
  $(".carousel").carousel({interval: 10000})
	$('.carousel-control-left').click ->
		alert('left')
	$('.carousel-control-right').click ->
		alert('right')

