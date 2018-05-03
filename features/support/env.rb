require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'

Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }


Capybara.app_host  = "https://www.amazon.com"
Capybara.run_server = false
Capybara.default_selector = :css
Capybara.default_max_wait_time = 15
Capybara.ignore_hidden_elements = true
Capybara.save_path = File.dirname(__FILE__) + "/media"
Capybara.default_driver = :selenium


Capybara.register_driver :chrome_headless do |app|
  # args = ["--window-size=1280,1696", "--disable-infobars", "--disable-notifications", "--no-sandbox", "--headless", "--disable-gpu"]  
  args = ["--disable-infobars", "--disable-notifications", "--no-sandbox", "--headless", "--disable-gpu"]  
  
  #Capybara::Selenium::Driver.new(app, {:browser => :chrome, :args => args})
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :samsungs6_v do |app|
  size = "360,640"
  user_agent = "Mozilla/5.0 (Linux; Android 6.0.1; SM-G920V Build/MMB29K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.98 Mobile Safari/537.36"
  args = ["--no-sandbox", "--headless", "--disable-gpu", "--window-size=#{size}", "--use-mobile-user-agent", "--disable-infobars", "--disable-notifications", "--user-agent=#{user_agent}"]
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :args => args})
end


Capybara.default_driver = :chrome_headless
Capybara.javascript_driver = :chrome_headless