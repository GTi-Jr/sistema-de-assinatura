adjustCloudToPlan = ->
    $('.pricing-plan').css('margin-top', ($('.cloud-image').height()/2.5 * (-1) + 'px')) # para deixar a nuvem certa com a caixa de preço

jQuery(document).ready ->
    adjustCloudToPlan()

    $(window).resize ->
        adjustCloudToPlan()
