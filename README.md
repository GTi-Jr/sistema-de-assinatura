## Sistema de assinaturas

* Ruby 2.3.1
* Rails 4.2.6

Para instalar as dependências e criar o banco de dados:
```
$ bundle install
$ rake db:create
$ rake db:migrate
```

Deploy:
```
$ cap production deploy
```

Modo de manutenção:
```
$ rake maintenance:start
$ rake maintenance:end
```

Para rodar os testes:
```
$ rspec
```
