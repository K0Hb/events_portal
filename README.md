# Веб-приложение «events_portal»

Приложение написанное на Rails 7 ( Ruby 3.0 ), с помощью которого можно организовывать события.

## Особенности и технологии

- Авторизация с помощью gem(a) devise, так же есть возможность авторизоваться через аккаунты github/yandex
- Стилизация с помощью фреймворка Bootstrap
- Загрузчик изображений  Carrierwave + rmagick
- Локализация i18n
- Отправка почты с помощью Postfix
- Хранение файлов не yandex bucket по протоколу AWS


## Основные функции

- Регистрация
- Добавление аватарки пользователя
- Создание события (только для зарегистрированных пользователей)
- Возможность подписаться на событие
- Возможность оставлять к событию комментарии
- Возможность доступа к событию только по пинкоду
- Создание галереи фотографий


## Запуск на локальном сервере

Загрузите репозиторий приложения.

>
> ВАЖНО! Предварительно установите гем 'bundle', если у вас его > нет:
>
>```
> gem install bundle
> ```

Из корневой папки используем команды:

Установка зависимостей

```
bundle install
```

Прогонияем миграции

```
bundle exec rails db:migrate
```

Запуск сервера:

```
bundle exec rails s
```

Сайт будет доступен по адресу localhost:3000

## Добавление ключей

Для использования всего функционала приложения пропише ключи в [credentails](https://edgeguides.rubyonrails.org/security.html) в формате:
```
yandex:
  # backet
  access_key_id:
  secret_access_key:
  apikey:

  # authorization
  client_id:
  client_secret:

github:
  client_id:
  client_secret:

secret_key_base:
```

## Deploy

Развернутое приложение доступно по [ссылке](https://events-portal-22082022.herokuapp.com/)
