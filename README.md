rspec matchers: https://rubydoc.info/gems/rspec-expectations/frames
(rails specific extras: https://relishapp.com/rspec/rspec-rails/v/4-0/docs/matchers)


HEROKU:
- buildpacks (for activestorage):
> heroku buildpacks:add -i 1 https://github.com/heroku/heroku-buildpack-activestorage-preview


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