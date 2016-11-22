$(document).ready ->
    welcomeImageHeight = $(window).height() - $('.stiky-header').height()
    $('section#welcome').css('min-height', welcomeImageHeight + 'px') # para deixar o início pegando a tela inteira
