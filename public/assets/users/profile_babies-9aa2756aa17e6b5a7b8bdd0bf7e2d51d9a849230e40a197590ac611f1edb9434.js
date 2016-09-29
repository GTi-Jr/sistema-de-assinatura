$(document).ready(function() {
    for(i = 0; i < $('.babies').length; i++) {
        var id = $($('.babies').get(i)).attr('data-id');

        if($('#baby-born-select-' + id).val() === '0') {
            $('#baby-weeks-' + id).show();
            $('#baby-birthdate-' + id).hide();
        }
        else {
            $('#baby-weeks-' + id).hide();
            $('#baby-birthdate-' + id).show();
        }
    }

    profileBabyBornChanged($('#baby-born-select-new'));
});

function profileBabyBornChanged(div) {
    var id = $(div).attr('id').split('-')[3];

    if($(div).val() === '0') {
        $('#baby-weeks-' + id).show();
        $('#baby-birthdate-' + id).hide();
    }
    else {
        $('#baby-weeks-' + id).hide();
        $('#baby-birthdate-' + id).show();
    }
}

;
