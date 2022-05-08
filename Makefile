install:
	yarn install
	bundle install
test:
	bin/rails test
lint:
	bundle exec rubocop
	slim-lint app/views
migrate:
	bin/rails db:migrate
seed:
	bin/rails db:seed
start:
	bin/rails s
.PHONY: test