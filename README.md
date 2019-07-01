# Ansible-Task-2

## Описание

- Данный репозиторий служит описанием по созданию виртуальной машины в сервисе [aws](https://aws.amazon.com)
	- а так же установки через ansible - nginx
	- а так же создания виртуальных хостов и их активация, с последующей перезагрузкой nginx сервиса
		- в файле /ansible/vars/main.yml - описывается список необходимых хостов
	- на выходе получаем ip-адрес созданной машины и установленный на ней nginx со всеми хостами
### Доп. требования
- предполагается, что вы уже зарегистрированы на [aws](https://aws.amazon.com) и сгенерировали себе персональный [токен](https://console.aws.amazon.com/iam/home)
- для начально работы (в MacOS) необходимо установить [terraform](https://www.terraform.io)
  > brew install terraform

- и [Go](https://golang.org/)
  > brew install go

- а так же ansible
	> brew install ansible

#### Создание виртуальной машины и заполнение переменных
 - переименовываем файл **vars.tf.example** в **vars.tf**
 - заполняем переменные по вашему усмотрению
 - в файле /ansible/vars/main.yml - описывается список необходимых хостов
 - инициализируем:
 	> terraform init

 - проверяем на ошибки:
	> terraform plan

 - создаем ВМ:
 	> terraform apply

##### Автор
 - **Vassiliy Yegorov** - *Initial work* - [vasyakrg](https://gitlab.rebrainme.com/vasyakrg)
