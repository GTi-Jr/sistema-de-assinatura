$(document).ready ->
    $('.bx-slider').bxSlider({
      mode: 'fade',
      adaptiveHeight: true,
      controls: false,
      touchEnabled: true,
      pager: true
    })
    # Fix slider height
    $('.bx-wrapper').parent().height($(window).height() - $('.stiky-header').height() - $('.bx-controls').height())
