plan_1 = Plan.new name: 'Plano Mensal', duration: 1, price: 74.90, description: 'Todo mês um mundo de surpresas chegando até você!'
plan_2 = Plan.new name: 'Plano Trimestral', duration: 3, price: 209.70, description: 'Três meses de muito carinho e muitas novidades!'
plan_3 = Plan.new name: 'Plano Semestral', duration: 6, price: 389.40, description: 'Durante seis meses você recebe uma linda caixinha preparada especialmente para você!'

plan_1.save
plan_2.save
plan_3.save
