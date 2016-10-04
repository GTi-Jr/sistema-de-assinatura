$(document).ready ->
    $('.parallax').each (index, value) ->
        $(this).css 'background-image', "url(#{$(this).attr 'image-url'})"
        $(this).css 'height', $(this).attr 'height' if $(this).attr 'height'
