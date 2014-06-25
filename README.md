spree_zoned
===========

Spree Zoned makes Spree stores international.

By enhancing the Zone model to include a currency, customer's can be billed in their own currency.

Products can easily have a price per currency.

Customer's can choose their local Zone. The prices in the Store will be updated to reflect their local currency.

### Accessing the active zone from views

A view helper has been added to access the Zone for the current customer. `active_zone` returns the `Spree::Zone`
chosen by the customer, or the default Zone configured for the store.

Installation
------------

Add spree_zoned to your Gemfile:

```ruby
gem 'spree_zoned', git: 'https://github.com/A-James/spree_zoned'
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_zoned:install
```

Development
-----------

Vagrant can be used to boot up an environment that's already configured for developing on the gem.

```shell
vagrant up
```

This will start the box and provision it with the required dependencies.

The source code will be located in the /vagrant directory on the VM.

Manual Testing
--------------

The gem includes a test Spree store that can be used for manual testing in the ./sandbox directory.

**Setting up the sandbox**

To run the teststore for the first time run the commands below. This will configure the database and add the required test data.

```shell
cd sandbox
bundle

# Set up the database
bundle exec rake railties:install:migrations
bundle exec rake db:migrate
bundle exec rake db:seed
bundle exec rake spree_sample:load

# Start the web server
rails s
```

**Starting the sandbox**

From then onwards you should be able to just run from the sandbox directory.

```shell
rails s
```

The port for the sandbox will be forwarded from port 30000 on your local machine.

When the store is running you should be able to visit https://lvh.me:30000 to see the store running on the VM.

Copyright © 2014, 200 X Ltd trading as 200 Creative. All rights reserved.
