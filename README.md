# README
## MonteCinema API Server 
This is a simple API Server, which allows to buy cinema tickets. 

## Technologies 
* Ruby 2.7.0
* Rails 6.1.4
* Sidekiq 4.1.2
* PostgreSQL 13.4

## Install & run 

```
# Clone the repo locally
$ git clone git@github.com:lilka/monteCinema-api.git

# Install required gems: 
$ bundle install 

# Create and seed database 
$ rails db:create db:migrate db:seed

# Run rails server 
$ rails s 

# Run sidekiq
$ bundle exec sidekiq
```

The app is ready now to use at http://localhost:3000

## Run test 
```
$ rspec 
```






