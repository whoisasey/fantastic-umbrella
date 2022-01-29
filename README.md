# README

## Before beginning make sure you have the following:

- Rails: follow the guide here (select your system/OS) [https://gorails.com/setup/osx/10.14-mojave]
- install postgresql with your package manager of choice
- `brew services start postgresql`

## After cloning or opening the repo:

- `rails db:create`
- `rails db:migrate`
- `rails s`
- open your API Platform of choice and make a **\_\_\_** (for uploading csv)
- once uploaded, make a GET request to https://localhost:3000/employees
