Geocoder.configure(
  :timeout => 3,
  :lookup => :google,
  :language => :en,
  :use_https => true,
  :api_key => ENV['GOOGLE_API_TOKEN'],
  :units => :mi,
  :distances => :linear
)
