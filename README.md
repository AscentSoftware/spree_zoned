spree_zoned
===========

Spree Zoned makes Spree stores international.

By enhancing the Zone model to include a currency, customer's can be billed in their own currency.

Products can easily be configured to have a price per currency.

An IP to country lookup automatically configures the site to the correct zone. Customer's can override the Zone choice
manually.

The prices in the Store are displayed in the currency configured for the Active Zone.

Stock locations are assigned to Zones. The stock available to a customer is based on the stock
locations assigned to the customer's Zone. For example, with US and EU stock locations, the EU stock location would be
chosen for a European customer and the US stock location for a customer ordering to the US.

### Accessing the active zone & country from views

There are view helpers available to access the Zone & Country for the current customer. `active_zone` returns the `Spree::Zone`
chosen by the customer, or the default Zone configured for the store. `active_country` returns the `Spree::Country` detected
for the customer, or the last country they selected for their shipping address at checkout.

### Zone selector

Spree_zoned will automatically include the zone selector in the footer of a Spree store using the default layout.

The zone selector is contained within a partial that can be included in any view with a simple `render partial:` call.

```html+erb
<%= render partial: 'spree_zoned/shared/zone_selector' %>
```

### Inclusive Tax Rates

An inclusive tax rate is a tax rate that is marked as 'Included In Price'. A tax rate that might be modeled this way
is UK VAT.

Stores that want to use an inclusive tax rate need to be configured correctly.

1. Mark a zone as the default tax zone. It doesn't matter which zone you select as the default. We will be unmarking it
before we finish.
  1. Admin -> Configuration -> Zones -> Edit Zone
  2. Check 'Default Tax Zone' and save.
2. Mark your inclusive tax rate as 'Included In Price'.
  1. Admin -> Configuration -> Tax Rates -> Edit Tax Rate
  2. Check 'Included In Price' and save.
3. Remove the default tax zone.
  1. Admin -> Configuration -> Zones -> Edit Zone marked as default. This should be the zone you marked in step 1.
  2. Uncheck 'Default Tax Zone' and save.

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

The geoip2 library must be correctly configured to enable the automatic zone discovery by IP address feature.

The simplest way of configuring geoip2 is to create an initializer, in the config/initializers folder of your app, with
the config below:

```ruby
Geoip2.configure do |conf|
    # Available under 'My License Key' when signed in at maxmind.com.
    conf.user_id = 'user id goes here'
    conf.license_key = 'license key goes here'
end
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
bundle exec rails s
```

**Starting the sandbox**

From then onwards you should be able to just run from the sandbox directory.

```shell
bundle exec rails s
```

The store should be accessible at https://192.168.109.2:3000.

Copyright © 2015, 200 X Ltd trading as 200 Creative. All rights reserved.
