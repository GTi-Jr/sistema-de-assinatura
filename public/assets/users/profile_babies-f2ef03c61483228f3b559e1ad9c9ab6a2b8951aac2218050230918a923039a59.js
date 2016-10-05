(function() {
  window.profileBabyBornChanged = function(div) {
    var id;
    if (div.length) {
      id = $(div).attr('id').split('-')[3];
      if ($(div).val() === '0') {
        $('#baby-weeks-' + id).show();
        $('#baby-birthdate-' + id).hide();
      } else {
        $('#baby-weeks-' + id).hide();
        $('#baby-birthdate-' + id).show();
      }
    }
  };

  $(document).ready(function() {
    var i, id;
    i = 0;
    while (i < $('.babies').length) {
      id = $($('.babies').get(i)).attr('data-id');
      if ($('#baby-born-select-' + id).val() === '0') {
        $('#baby-weeks-' + id).show();
        $('#baby-birthdate-' + id).hide();
      } else {
        $('#baby-weeks-' + id).hide();
        $('#baby-birthdate-' + id).show();
      }
      i++;
    }
    profileBabyBornChanged($('#baby-born-select-new'));
  });

}).call(this);
