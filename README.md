# A rails-api/angularjs scaffolding app

Use this as a scaffolding for a simple web application made from rails-api for REST API back-end and AngularJS single-page app front-end. Besides users, it has a single trips entity which can be listed, created and deleted from a simple UI. 

## Examples of how to use Planly API

### Sign-in
curl -v -X POST "http://localhost:3000/api/auth/sign_in" -H "Content-Type: application/json" -H "Accept: application/vnd.trips+json" -d "{\"email\": \"one@example.com\", \"password\": \"12345\"}"

### Sign-out
curl -v -X DELETE "http://localhost:3000/api/auth/sign_out" -H "Accept: application/vnd.trips+json; version=1" -H "Access-Token: 8dnfPFS7V_kNyVongz0Xdg" -H "Token-Type: Bearer" -H "Client: Lkw2KoHnE4o827mpT_iZ7w" -H "Expiry: 1425486951" -H "Uid: one@example.com"

### Create new user
curl -v -X POST "http://localhost:3000/api/auth" -H "Content-Type: application/json" -H "Accept: application/vnd.trips+json" -d "{\"email\": \"two@example.com\", \"password\": \"12345\"}"\

### Get all trips
curl -v -X GET "http://localhost:3000/api/trips" -H "Accept: application/vnd.trips+json; version=1" -H "Access-Token: 8dnfPFS7V_kNyVongz0Xdg" -H "Token-Type: Bearer" -H "Client: Lkw2KoHnE4o827mpT_iZ7w" -H "Expiry: 1425486951" -H "Uid: one@example.com"

## Get a trip
curl -v -X GET "http://localhost:3000/api/trips/3234e1ca-2af6-448a-a383-142e558a5e18" -H "Accept: application/vnd.trips+json; version=1" -H "Access-Token: 8dnfPFS7V_kNyVongz0Xdg" -H "Token-Type: Bearer" -H "Client: Lkw2KoHnE4o827mpT_iZ7w" -H "Expiry: 1425486951" -H "Uid: one@example.com"

## Delete a trip
curl -v -X DELETE "http://localhost:3000/api/trips/3234e1ca-2af6-448a-a383-142e558a5e18" -H "Accept: application/vnd.trips+json; version=1" -H "Access-Token: 8dnfPFS7V_kNyVongz0Xdg" -H "Token-Type: Bearer" -H "Client: Lkw2KoHnE4o827mpT_iZ7w" -H "Expiry: 1425486951" -H "Uid: one@example.com"

## Get filtered trips
curl -v -X GET "http://localhost:3000/api/trips/filter?destination=wi" -H "Accept: application/vnd.trips+json; version=1" -H "Access-Token: 8dnfPFS7V_kNyVongz0Xdg" -H "Token-Type: Bearer" -H "Client: Lkw2KoHnE4o827mpT_iZ7w" -H "Expiry: 1425486951" -H "Uid: one@example.com"

## Get next month's trips
curl -v -X GET "http://localhost:3000/api/trips/next_month" -H "Accept: application/vnd.trips+json; version=1" -H "Access-Token: 8dnfPFS7V_kNyVongz0Xdg" -H "Token-Type: Bearer" -H "Client: Lkw2KoHnE4o827mpT_iZ7w" -H "Expiry: 1425486951" -H "Uid: one@example.com"
