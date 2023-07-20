### Hexlet tests and linter status:
[![Actions Status](https://github.com/Schartoym/ansible-project-76/workflows/hexlet-check/badge.svg)](https://github.com/Schartoym/ansible-project-76/actions)

# Проект Деплой Docker-образов с помощью Ansible
## Цель
Развернуть в облачном провайдере экземпляр приложения Redmine

## Требования
- Приложение запускается как  Docker контейнер
- Решение использует облачную инфраструктуру провайдеров
    - Облачную БД
    - Балансировшик нагрузки
- Приложение доступно из интернета по доменному имени и https
- Деплой приложения происходит через Ansible и используются следущие возможности 
    - Роли
    - Vault
    - Группы хостов
- У приложения настроен монтиторинг через DataDog

# Реализация

## Инфраструктура
Для реализации проекта было выбрано Яндекс Облако в качестве облачного провайдера и Cloudflare для DNS хостинга

Для развертывания инфраструктуры был использован [terraform](terraform). В описанной конфигурации создаются виртуальные машины, кластре БД Postgres, балансировщик нагрузки, выпускаются сертификаты от Let's Encrypt и обновляются DNS записи. Подробнее описано в [папке проекта terraform](terraform)

После запуска terraform генерирует [inventory файл](inventory.ini)

## Ansible
Основной playbook - [playbook.yml](playbook.yml)

### Роли
Описаны две роли
- [roles/docker](roles/docker) устанавливает если необходимо Docker на хостах

- [roles/redmine](roles/redmine) запускает Redmine на хостах

- [roles/datadog](roles/datadog) устанавливает и запускает DataDog agent

### Группы хостов
Хосты, на которые должен быть установлен Redmine выделены в группу `webservers`

### Зависимости
Зависимости описаны в [requirements.yml](requirements.yml)


### Запуск
Для удобства добавлен [Makefile](Makefile)

Доступные команды

- Установка зависимостей 
```bash
make dependencies
```

- Проверка playbook
```bash
make check
```

- Запуск playbook
```
make
```

- Редактирование vault для группы `webservers`
```bash
make edit-vault-webservers
```
