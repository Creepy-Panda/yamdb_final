![example workflow](https://github.com/creepy-panda/yamdb_final/actions/workflows/yamdb_workflow.yml/badge.svg)

  




# Проект YaMDb





Сервис сбора отзывов о произведениях: книгах, фильмах, музыке.

## Авторы:

*<a  href="https://github.com/Creepy-Panda">Vladislav Nosikov</a>
<a  href="https://github.com/DD477">d.dobrodeev</a>
<a  href="https://github.com/Ivan-Skvortsov">Ivan-Skvortsov</a>*

  

## О проекте

Проект YaMDb собирает отзывы пользователей на произведения. Произведения делятся на категории: «Книги», «Фильмы», «Музыка». Список категорий может быть расширен администратором (например, можно добавить категорию «Изобразительное искусство» или «Ювелирка»).

Сами произведения в YaMDb не хранятся, здесь нельзя посмотреть фильм или послушать музыку.

В каждой категории есть произведения: книги, фильмы или музыка. Например, в категории «Книги» могут быть произведения «Винни-Пух и все-все-все» и «Марсианские хроники», а в категории «Музыка» — песня «Давеча» группы «Насекомые» и вторая сюита Баха.

Произведению может быть присвоен жанр из списка предустановленных. Новые жанры может создавать только администратор.

Благодарные или возмущённые пользователи оставляют к произведениям текстовые отзывы и ставят произведению оценку в диапазоне от одного до десяти (целое число); из пользовательских оценок формируется усреднённая оценка произведения — рейтинг (целое число). На одно произведение пользователь может оставить только один отзыв.

  

## Использованные технологии

* [Docker](https://www.docker.com/)

* [Django](https://www.djangoproject.com/)

* [Django REST framework](https://www.django-rest-framework.org/)

* [Simple JWT](https://django-rest-framework-simplejwt.readthedocs.io/en/latest/)

  

## Необходимый софт

Для развертывания проекта вам потребуется Docker.

  

## Установка

Склонируйте проект на Ваш компьютер

```sh

git clone https://github.com/Creepy-Panda/yamdb_final.git

```

Перейдите в папку с docker-compose

```sh

cd infra/

```

Запустите контейнер

```sh

docker-compose up

```

  

Для того чтобы выключить контейнер

```sh

docker-compose down

```

  
  

## Использование

Выполнить миграции

```sh

docker-compose run web python manage.py migrate

```

Создать суперпольозвателя(администратор) Django

```sh

docker-compose run web python manage.py createsuperuser

```

Пример стартовых данных

```sh

docker-compose run web python manage.py loaddata fixtures.json

```

  

* [Документация API доступна по адресу /redoc](http://51.250.23.249/redoc/)

* Для работы с API используйте любой удобный для Вас инструмент



  
  

## Пользовательские роли

  

-  **Аноним** — может просматривать описания произведений, читать отзывы и комментарии.

-  **Аутентифицированный пользователь (user)** — может читать всё, как и Аноним, может публиковать отзывы и ставить оценки произведениям (фильмам/книгам/песенкам), может комментировать отзывы; может редактировать и удалять свои отзывы и комментарии, редактировать свои оценки произведений. Эта роль присваивается по умолчанию каждому новому пользователю.

-  **Модератор (moderator)** — те же права, что и у Аутентифицированного пользователя, плюс право удалять и редактировать любые отзывы и комментарии.

-  **Администратор (admin)** — полные права на управление всем контентом проекта. Может создавать и удалять произведения, категории и жанры. Может назначать роли пользователям.

-  **Суперюзер Django** обладает правами администратора, пользователя с правами admin. Даже если изменить пользовательскую роль суперюзера — это не лишит его прав администратора.

## Регистрация пользователей

  

- Пользователь отправляет POST-запрос с параметрами email и username на эндпоинт /api/v1/auth/signup/.

- Сервис YaMDB отправляет письмо с кодом подтверждения (confirmation_code) на указанный адрес email.

- Пользователь отправляет POST-запрос с параметрами username и confirmation_code на эндпоинт /api/v1/auth/token/, в ответе на запрос ему приходит token (JWT-токен).

В результате пользователь получает токен и может работать с API проекта, отправляя этот токен с каждым запросом.

  

После регистрации и получения токена пользователь может отправить PATCH-запрос на эндпоинт /api/v1/users/me/ и заполнить поля в своём профайле (описание полей — в документации redoc).


  

## Создание пользователя администратором

  

Пользователя может создать администратор — через админ-зону сайта или через POST-запрос на специальный эндпоинт api/v1/users/ (описание полей запроса для этого случая — в документации). В этом случае письмо пользователю не отправляется.

  

После этого пользователь должен самостоятельно отправить свой email и username на эндпоинт /api/v1/auth/signup/, в ответ ему придет письмо с кодом подтверждения.

  

Далее пользователь отправляет POST-запрос с параметрами username и confirmation_code на эндпоинт /api/v1/auth/token/, в ответе на запрос ему приходит token (JWT-токен), как и при самостоятельной регистрации.
