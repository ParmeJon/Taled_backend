# TaleD Backend

TaleD is a blog geared towards solo travelers. With the increase of solo travels over the years the dangers and worry for our friends have increased as well. TaleD services as both a way to keep your friends and family updated and a blog for your trip.

## Frontend Link

https://github.com/ParmeJon/Taled_frontend

## Installation

```
bundle i
rails db:create db:migrate
```
## Environment Variables

Create a .env file containing the following:

```
export SECRET_TOKEN="YOUR SECRET FOR JWT"
```
Create an AWS account and S3 bucket.
Optional - encrypt with Rails Credentials and Master Key.
Set up amazon_dev in a config/locales/storage.yml file to manage file uploads:

```
amazon_dev:
  service: S3
  access_key_id: YOUR KEY ID
  secret_access_key: YOUR SECRET ACCESS KEY
  region: YOUR REGION
  bucket: YOUR BUCKET
secret_key_base: YOUR AWS SECRET KEY BASE
```

## Run

Start up backend server before front end.

```
rails s
```

## Features

### User Authentication
- JWT token decrypted and encrypted with .env SECRET TOKEN

### Action Cable
- action cable implemented to facilitate receiving a friend request without refresh upon friendship creation.

### Serializers
- Serializers implemented to optimize information transfer for a certain User.

### Self Referential Table
- Used to facilitate User having many other Users(Friends) through Friendships.

## Built With

- Ruby On Rails Backend

## Created By

Jonathan Chan github.com/ParmeJon
