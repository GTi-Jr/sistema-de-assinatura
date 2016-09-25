$(document).ready(function() {
    for(i = 0; i < $('.babies').length; i++) {
        var id = parseInt($($('.babies').get(i)).attr('data-id'));

        console.log(id + ': ' + $('#baby-born-select-' + id).val());

        if($('#baby-born-select-' + id).val() === '0') {
            $('#baby-weeks-' + id).show();
            $('#baby-birthdate-' + id).hide();
        }
        else {
            $('#baby-weeks-' + id).hide();
            $('#baby-birthdate-' + id).show();
        }
    }
});

function profileBabyBornChanged(div) {
    var id = parseInt($(div).parent().parent().attr('data-id'));

    if($(div).val() === '0') {
        $('#baby-weeks-' + id).show();
        $('#baby-birthdate-' + id).hide();
    }
    else {
        $('#baby-weeks-' + id).hide();
        $('#baby-birthdate-' + id).show();
    }
}
