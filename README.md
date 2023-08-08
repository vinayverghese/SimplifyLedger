## SIMPLIFY LEDGER

This is a Ruby on Rails app. In order to run it locally, you must have the latest version of Ruby installed. It also requires `bundler` and `npm` or `yarn`.

This article covers the required steps:
https://medium.com/@dyanagi/how-to-run-an-existing-ruby-on-rails-project-after-cloning-a-repository-8535e4f14bc9

## APPLICATION

The application will be available locally here: `http://localhost:3000/`

The deployed version is available here: `https://simplify-ledger-06aefb87ee3d.herokuapp.com/` 
## CONSIDERATIONS MADE

- The main page has a file upload option that only accepts json files. Other formats will not be accepted.
- The json file that is accepted in the prescribed format will be parsed and the following operations will be made:
    - Any duplicate activity IDs will be ignored. Based on the sample data, any transactions with duplicate IDs contained identical data.
    - Total balance was calculated separate from the final balance and compared. If there was a mismatch, the calculated total balance was considered the accurate final balance.
    - Description: Combining the type and description of source and destination, a custom description was provided.

## TECHNICAL CONSIDERATIONS

- A database has not been used here, since there was no need to store any data. However, it can be incorporated if required.
