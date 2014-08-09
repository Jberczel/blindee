# config/initializers/high_voltage.rb
HighVoltage.configure do |config|
  
  # root high_voltage#home
  config.home_page = 'home'

  # /pages/about => /about
  config.route_drawer = HighVoltage::RouteDrawers::Root
end