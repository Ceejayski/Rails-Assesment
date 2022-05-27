# README

Rails Sample REST API Application

## Commands
  - run `rails server` to start the server
  - run `rails db:create` to create the database
  - run `rails db:migrate` to migrate the database
  - run `rails db:seed` to seed the database
  - run `bundle exec rspec` to run the tests
## Description

The application needs two components:

1. The ability to create and manage players.
2. A JSON API endpoint to share this data.

Part I: Creating and Managing Players

1. Rails application needs basic CRUD abilities for Players. Players will have:

- First Name (can be blank)
- Last Name (must be present)
- Number (must be positive integer < 100)
- Image (use ActiveStorage)

2. Create pages or actions necessary to:

- List all created players
- Update a player
- Create a new player
- Delete an existing player

## API DOCUMENTATION

### GET ALL PLAYERS

#### Request

`GET api/v1/players`
curl -i -H 'Accept: application/json' http://localhost:3000/api/v1/players

#### Response

HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Content-Type: application/json; charset=utf-8
ETag: W/"ec2263e65f8d76c6ba4f2e515cc4905d"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: c6c442c2-ec2e-40ea-a0dc-741a902bc356
X-Runtime: 0.057479
Transfer-Encoding: chunked

    {
      # array
     "players": [
        {
            "id": 20,
            "first_name": "Royal Gutmann",
            "last_name": "Walton Bahringer",
            "number": 99,
            "image": "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBHUT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--344083c969954bf793b6eafef85f96442e14c87a/sample.jpg"
        },
        {
            "id": 19,
            "first_name": "Haydee Dooley",
            "last_name": "Carri Emard CPA",
            "number": 60,
            "image": "/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBHQT09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--8b32321982ae4b4fa1b7e36d3e042d334b5b069f/sample.jpg"
        }
      ],
      #meta options
      "pagination": {
        "current_page": "/api/v1/players?page=1",
        "next_page": "/api/v1/players?page=2",
        "total_pages": 2,
        "total_count": 10
      },
    "error": false
    }

### Create New Player

#### Request

`POST api/v1/players`
curl -i -H 'Accept: application/json' --location --request POST 'http://localhost:3000/api/v1/players' \
--form 'first_name="test"' \
--form 'last_name="test"' \
--form 'number="1"'

#### Response

HTTP/1.1 201 Created
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Content-Type: application/json; charset=utf-8
ETag: W/"cfd98db47dfc1566dcb5fd1715a87da1"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: 2d48c3ed-1d11-485e-b9e2-b90f328aa2e6
X-Runtime: 0.033323
Transfer-Encoding: chunked

    {
      "error": false,
      "data": {
          "id": 21,
          "first_name": "test",
          "last_name": "test",
          "number": 1,
          "image": ""
      }
    }

### Update Player Info

#### Request

`PUT api/v1/players/1`
curl -i -H 'Accept: application/json' --location --request PUT 'http://localhost:3000/api/v1/players/9' \
--form 'first_name="test"' \
--form 'last_name="test"' \
--form 'number="1"'

#### Response

HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Content-Type: application/json; charset=utf-8
ETag: W/"92fd65991555c3d6cce68dc63cab8d8e"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: 74f5603d-33cc-4277-883f-c2969215abb4
X-Runtime: 0.031462
Transfer-Encoding: chunked

    {
      "error": false,
      "data": {
          "id": 1,
          "first_name": "test",
          "last_name": "test",
          "number": 1,
          "image": ""
      }
    }

### Delete Player

#### Request

`DELETE api/v1/players/1`
curl --location --request DELETE 'http://localhost:3000/api/v1/players/1'

#### Response

HTTP/1.1 200 OK
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Content-Type: application/json; charset=utf-8
ETag: W/"1a1d86c80e8998162cd023ab509f4f01"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: e2717de9-9a5d-4190-8b6e-a6ca754def40
X-Runtime: 0.024781
Transfer-Encoding: chunked

    {
      "message": "Player deleted successfully",
      "error": false
    }
