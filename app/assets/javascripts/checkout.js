window.disable_payment = function() {
  return $(".payment-method").hide();
};

window.enable_payment = function() {
  return $(".payment-method").show();
};

$(document).ready(function() {
  // Configure seu AccountID aqui
  Iugu.setAccountID("9035e476-422e-4d10-81bc-b86dd72e1364");

  $("#credit_card_details .credit_card_number").formatter({
    'pattern': '{{9999}} {{9999}} {{9999}} {{9999}}',
    'persistent': false
  });
  $("#credit_card_details .credit_card_expiration").formatter({
    'pattern': '{{99}}/{{99}}',
    'persistent': false
  });
  $("#credit_card_details .credit_card_cvv").formatter({
    'pattern': '{{9999}}'
  });
  $("#credit_card_details .credit_card_number").on("keyup", function(evt) {
    var brand, number;
    number = $(this).val();
    number = number.replace(/\ /g, "");
    number = number.replace(/\-/g, "");
    $("#credit_card_details").removeClass("visa");
    $("#credit_card_details").removeClass("mastercard");
    $("#credit_card_details").removeClass("amex");
    $("#credit_card_details").removeClass("diners");
    brand = Iugu.utils.getBrandByCreditCardNumber(number);
    if (brand) {
      $("#credit_card_details").addClass(brand);
      if (brand === "amex") {
        $("#credit_card_details .credit_card_number").formatter().resetPattern('{{9999}} {{9999999}} {{99999}}');
      } else if (brand === "diners") {
        $("#credit_card_details .credit_card_number").formatter().resetPattern('{{9999}} {{999999}} {{9999}}');
      } else {
        $("#credit_card_details .credit_card_number").formatter().resetPattern('{{9999}} {{9999}} {{9999}} {{9999}}');
      }
    }
    return true;
  });
  $("form").submit(function(evt) {
    var form, name, tokenResponseHandler;
    form = $(this);
    form.find("button .btn-danger").prop('disabled', true);
    if ($('input[name=payment_method]:checked').val() === "credit_card" && $('input[name=credit_card_token]').val().length === 0) {
      evt.preventDefault();
      if ($('.payment-method').is(':hidden')) {
        return form.get(0).submit();
      }
      $("#credit_card_details").removeClass("has-error");
      $(".cc_error").hide();
      name = $("#credit_card_details .credit_card_name").val().split(" ");
      $("#credit_card_details .credit_card_first_name").val(name.shift());
      $("#credit_card_details .credit_card_last_name").val(name.join(" "));
      tokenResponseHandler = function(data) {
        if (data.errors) {
          form.find("button .btn-danger").prop('disabled', false);
          $(".cc_error").show();
          return $("#credit_card_details").addClass("has-error");
        } else {
          $("#credit_card_token").val(data.id);
          return form.get(0).submit();
        }
      };
      var description = $('input[name=description]');
      if(description.length > 0 && (description.val() == undefined || description.val().length == 0)){
        return description.parent().addClass("has-error");
      }
      Iugu.createPaymentToken(this, tokenResponseHandler);
    }
    return true;
  });
  if ($('#credit_card_token').val() !== "") {
    $("#credit_card_details").hide();
    disable_payment();
  }
  if ($('input[name=payment_method]:checked').val() === "bank_slip") {
    $("#credit_card_details").hide();
  }
  $(".payment-select label.credit_card").on("click", function(e) {
    return $("#credit_card_details").show();
  });
  $(".payment-select label.bank_slip").on("click", function(e) {
    return $("#credit_card_details").hide();
  });
});
