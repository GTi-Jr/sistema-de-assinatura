$(document).ready(function(){
    $('.date-field').mask('Dd/Mm/0000', {'translation': {
        D: {pattern: /[0-3]/},
        d: {pattern: /[0-9]/},
        M: {pattern: /[0-1]/},
        m: {pattern: /[0-9]/}
    }});
    $('.rg-field').mask('0000000000000000000')
    $('.cpf-field').mask('000.000.000-00');
    $('.phone-field').mask('(00) 000000000');
    $('.zipcode-field').mask('00000-000');
});
