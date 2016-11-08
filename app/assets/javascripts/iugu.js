Iugu.setAccountID("EA277AB22D7341AD928880D36E44C11B");
Iugu.setTestMode(true);

jQuery(function($) {
  $('#payment-form').submit(function(evt) {
      var form = $(this);
      var tokenResponseHandler = function(data) {

          if (data.errors) {
              // console.log(data.errors);
              alert("Erro salvando cartão: " + JSON.stringify(data.errors));
          } else {
              $("#token").val( data.id );
              form.get(0).submit();
          }

          // Seu código para continuar a submissão
          // Ex: form.submit();
      }

      Iugu.createPaymentToken(this, tokenResponseHandler);
      return false;
  });
});
