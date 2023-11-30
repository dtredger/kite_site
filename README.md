
This is a kiteboarding directory rails app. It lists countries and kite-spots, and lets a user sign up and favourite them.
Currently it has some basic searching, and the ability to calculate distance from the user.

Uses:

* Rails 6.1

* Render platform

* DigitalOcean Spaces for storage

* ActiveStorage for files

* Unsplash API for placeholder images

* Wikipedia-scraped placeholder descriptions

* Rspec/selenium for model/system specs



rspec matchers: https://rubydoc.info/gems/rspec-expectations/frames
(rails specific extras: https://relishapp.com/rspec/rspec-rails/v/4-0/docs/matchers)


HEROKU:
- buildpacks (for activestorage):
> heroku buildpacks:add -i 1 https://github.com/heroku/heroku-buildpack-activestorage-preview

> heroku push
> heroku pg:push mylocaldb DATABASE_URL --app sushi
> heroku run rake:assets:precompile
> heroku restart
(for no-downtime pume restart use
bundle exec pumactl phased-restart

> blobs uploaded to local or mirror have to get their service changed to load from digitalocean
blobs.each do |blob|
  blob.update(service_name: 'digital_ocean')


Credentials Editing:

> EDITOR="atom --wait" rails credentials:edit

#Optimization Tools / Gems

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


####activestorage

variant_record = ActiveStorage::VariantRecord.where(blob_id: 904, 'variation_digest': 'qn9hs8VU+VtaWWNiKp0JwwZ5pl0=')

variant_attachments = ActiveStorage::Attachment.where(record_id: 429, record_type: 'ActiveStorage::VariantRecord')

blob = ActiveStorage::Blob.find(1476)
