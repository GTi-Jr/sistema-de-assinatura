$(document).ready(function () {
    $('#baby-birthdate').hide();
});

function babyBornChanged () {
    if ($('#user_babies_attributes_0_born').val() === '0') {
        $('#baby-months').show();
        $('#baby-birthdate').hide();
    }
    else {
        $('#baby-months').hide();
        $('#baby-birthdate').show();
    }
}
