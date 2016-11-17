$(document).ready(function() {
    Iugu.setAccountID("EA277AB22D7341AD928880D36E44C11B");
    Iugu.setTestMode(true); // Retirar esta linha para produção
    Iugu.setup();

    jQuery(function($) {
        $('#payment-form').submit(function(evt) {
            var form       = $(this);
            var tokenInput = $('#token');
            var tokenResponseHandler = function(data) {

                if (data.errors) {
                    // console.log(data.errors);
                    alert("Erro salvando cartão: " + JSON.stringify(data.errors));
                } else {
                    tokenInput.val(data.id);
                    form.get(0).submit();
                }
            }

            Iugu.createPaymentToken(this, tokenResponseHandler);


            return false;
        });
    });
});
