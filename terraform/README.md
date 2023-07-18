# Terrafrom конфигурация для проекта
Создает
- Две виртуальные машины
- Кластер PostgreSql
- Сетевой балансировщик нагрузки

## Провайдер
Используеутся Яндекс Облако

## Backend
В качестве хранилища состояния используется S3 бакет, настроенный по инструкции
https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-state-storage

## Quick Start
```bash
export ACCESS_KEY="<идентификатор_ключа>"
export SECRET_KEY="<секретный_ключ>"

terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"

terrafrom apply
```

## Переменные
### Общие
- `cloud_id` - Id облака
- `cloud_token` - Токен для доступа к облаку.
- `folder_id` - Id папки в облаке
- `service_account_id` - Id сервисного аккаунта
- `zone` - зона доступности. По умолчанию `ru-central-1`

### Для виртуальных машин
- `image_id` - Id образа. Чтобы получить список всех доступных
```
yc compute image list --folder-id standard-images
```
- `ssh_public_key_file` - путь до файла с публичным ключом

### Для Postgresql
- `database_user` - пользователь БД
- `database_password` - пароль для пользователя БД

### Секреты
в файле `secret.auto.vars` (добавлен в `.gitignore`) хранятся секреты:
- `cloud_token` 
- `database_user`
- `database_password`


