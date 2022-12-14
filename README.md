About the project
Mintly is an App designed to help NFT collectors monitor the value of their NFT portfolio. Without an app to track the NFTs, users would be required to keep a spreasheet and manually bring in price data on a daily basis. With mintly all that is done in the background via API calls to price oracles. The app calculates the PnL of each purchase as well as the PnL of the overall portfolio. ✨ Future features on the works: Optimising database calls to make the app faster; automated price refresh in the background and more real time data; connecting to crypto exchanges and wallets to download assets and positions automatically without necessity to input them manually. ✨

Versions
Tech Stack
Installation
Setup
In order to run our app locally, you will need to have already installed Yarn and Rails. Check them with:

$ yarn -v $ rails --version

If no version number is returned, please install Yarn and/or Rails before continuing.

Run the following command to create a database, load the schema, and initialize it with our seed data. $ rails db:create db:migrate db:seed

Dependencies
You'll also need to install all dependencies of the project with:

$ bundle install && yarn install

The bundle command installs all Ruby Gems specified in our Gemfile. The yarn install command retrieves all dependencies from the project’s package.json file.

API Keys
You will need an API key for Rarify to retrieve price data.
