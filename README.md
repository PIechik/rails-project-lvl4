# Github Quality Analyzer
### Hexlet tests and linter status:
[![Actions Status](https://github.com/PIechik/rails-project-lvl4/workflows/hexlet-check/badge.svg)](https://github.com/PIechik/rails-project-lvl4/actions)
[![Test and lint](https://github.com/PIechik/rails-project-lvl4/actions/workflows/test-lint.yml/badge.svg)](https://github.com/PIechik/rails-project-lvl4/actions/workflows/test-lint.yml)

### Description
  This service runs linter checks on repositories. After signing in through GitHub you will be able to add repositories from your account. Checks can be runned manually or automatically by pushing to your repository. If the linter check fails or offenses are detected then you will recieve an email.  Offenses will be displayed on a check show page.
### Demo
[Heroku](https://github-quality-hexlet.herokuapp.com/)

### System requirements
- Ruby
- Node.js
- Yarn
- SQLite3
- Heroku CLI

### Instalation
```
make install
make migrate
make seed
make start
```
To run tests and linting
```
make test
make lint
```