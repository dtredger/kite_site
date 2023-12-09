#TBA Kite Site

![]("public/readme_imgs/homepage.jpg")

This is a kiteboarding directory rails app. It lists countries and kite-spots, and lets a user sign up and favourite them.
Currently it has some basic searching, and the ability to calculate distance from the user.

There is an admin dashboard (using administrate) that allows basic actions on those models.

There is dummy descriptions (scraped from wikipedia) with a rake task. There are also (normally) images (from an unsplash rake task), but not currently enabled (since I ran out of digitalocean credits)

Uses:

* Rails 6.1
* Koyeb for app hosting + Postgres
* [formerly] DigitalOcean Spaces for file storage [not active]
* Unsplash API for placeholder images
* Wikipedia-scraped placeholder descriptions
* Rspec/selenium for model/system specs



---
### Setup

To create seed data, there is a CSV called `Sailing Sheet - Kite Spots` in lib/assets. Running `db:seed` will create countries and kitespots relating to all the locations in that file.

Once the Country and KiteSpot models are created, there are two rake tasks that can populate them with background descriptions and stock images:

> manage_descriptions:scrape_wiki

This adds a paragraph about the given country from wikipedia

> manage_images:load_from_unsplash

This loads 3 images for the given Country/KiteSpot from Unsplash (requires Unsplash API key)


---
### Tools/Services used

Annotate
> automatic comments of schema on model

Bullet
> development & test - looks for n+1 queries

lol_dba
> installed on system NOT added to gemfile
> to find missing indices
> lol_dba db:find_indexes

Guard
> test-runner that watches for changes

Rubocop
> style linter
> rubocop -A to have it autocorrect if possible

Simplecov
> generates coverage report

Brakeman
> automated security checks

redis
> redis-server /usr/local/etc/redis.conf

Mailcatcher (for dev)
> mailcatcher (starts daemon; view at :1080)

Mail API
 > Sendgrid SMTP Relay
 > Username	apikey
 > Password	{{sendgrid_mailer_key}}

Nginx
(when not using port 80, sudo not required)  
 > nginx -c {{full_path}}/config/nginx-osx.conf

 Foreman (for starting processes in procfile)
 > foreman start
