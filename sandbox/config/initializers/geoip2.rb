require 'geoip2'

Geoip2.configure do |conf|
  # Available under 'My License Key' when signed in at maxmind.com.
  conf.user_id = '90977'
  conf.license_key = 'cQBE0GGiRoQK'
end
