# These defaults are used in Geokit::Mappable.distance_to and in acts_as_mappable
   Geokit::default_units = :miles # others :kms, :nms, :meters
   Geokit::default_formula = :sphere

   # This is the timeout value in seconds to be used for calls to the geocoder web
   # services.  For no timeout at all, comment out the setting.  The timeout unit
   # is in seconds.
   Geokit::Geocoders::request_timeout = 3

   # This setting can be used if web service calls must be routed through a proxy.
   # These setting can be nil if not needed, otherwise, a valid URI must be
   # filled in at a minimum.  If the proxy requires authentication, the username
   # and password can be provided as well.
   Geokit::Geocoders::proxy = nil

   # This is your Google Maps geocoder keys (all optional).
   # See http://www.google.com/apis/maps/signup.html
   # and http://www.google.com/apis/maps/documentation/#Geocoding_Examples
   #Geokit::Geocoders::GoogleGeocoder.client_id = ''
   #Geokit::Geocoders::GoogleGeocoder.cryptographic_key = ''
   #Geokit::Geocoders::GoogleGeocoder.channel = ''

   # You can also use the free API key instead of signed requests
   # See https://developers.google.com/maps/documentation/geocoding/#api_key
   Geokit::Geocoders::GoogleGeocoder.api_key = 'AIzaSyAdR-KG7vzpZ0n0LKvTqPV2uvLWe8pnVFs'

   # require "external_geocoder.rb"
   # Please see the section "writing your own geocoders" for more information.
   # Geokit::Geocoders::external_key = 'REPLACE_WITH_YOUR_API_KEY'

   # This is the order in which the geocoders are called in a failover scenario
   # If you only want to use a single geocoder, put a single symbol in the array.
   # Valid symbols are :google, :yahoo, :us, and :ca.
   # Be aware that there are Terms of Use restrictions on how you can use the
   # various geocoders.  Make sure you read up on relevant Terms of Use for each
   # geocoder you are going to use.
   Geokit::Geocoders::provider_order = [:google]