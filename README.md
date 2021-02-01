rspec matchers: https://rubydoc.info/gems/rspec-expectations/frames
(rails specific extras: https://relishapp.com/rspec/rspec-rails/v/4-0/docs/matchers)


HEROKU:
- buildpacks (for activestorage):
> heroku buildpacks:add -i 1 https://github.com/heroku/heroku-buildpack-activestorage-preview


Credentials Editing:

> EDITOR="atom --wait" rails credentials:edit

##Optimization Tools / Gems

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