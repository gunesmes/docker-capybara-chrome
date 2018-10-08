require 'capybara'
require 'spec'
require 'rspec'
require 'capybara/cucumber'
require 'action_mailer'
require 'rspec-rerun/tasks'
require 'selenium-webdriver'


Dir['*.rb'].each {|file| require file }


driver = (ENV['DRIVER']).to_sym if not ENV['DRIVER'] == nil
orientation = (ENV['O']) if not ENV['O'] == nil
# this will be printed in cucumber report when failures occur
Capybara.session_name = ENV['RUN_COMMAND']
Capybara.app_host  = ENV['SITE_NAME'] || "https://www.gittigidiyor.com"
Capybara.run_server = false
Capybara.default_selector = :css
Capybara.default_max_wait_time = 30
Capybara.ignore_hidden_elements = true
Capybara.save_path = File.dirname(__FILE__) + "/media"

Capybara.javascript_driver = driver || :chrome
Capybara.default_driver    = driver || :chrome

# * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
# * * * * * * * * * *  D R I V E R S  * * * * * * * * * * *
# * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


Capybara.register_driver :driver_chrome do |app|
  args = ["--start-fullscreen", "--disable-infobars", "--disable-notifications"]
  
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :driver_mobile_iphone6_v_visible do |app|
  size = "375,667"  
  user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1"
  args = ["--window-size=#{size}", "--use-mobile-user-agent", "--disable-infobars", "--disable-notifications", "--user-agent=#{user_agent}"]
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :driver_mobile_iphone6_v do |app|
  size = "375,667"  
  user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1"
  args = ["--window-size=#{size}", "--use-mobile-user-agent", "--disable-infobars", "--disable-notifications", "--user-agent=#{user_agent}", "--no-sandbox", "--headless"]
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :driver_mobile_iphone6_h do |app|
  size = "667,375"
  user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1"
  args = ["--window-size=#{size}", "--use-mobile-user-agent", "--disable-infobars", "--disable-notifications", "--user-agent=#{user_agent}", "--no-sandbox", "--headless"]  
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :driver_mobile_iphone6plus_v do |app|
  size = "414,738"
  user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1"
  args = ["--window-size=#{size}", "--use-mobile-user-agent", "--disable-infobars", "--disable-notifications", "--user-agent=#{user_agent}", "--no-sandbox", "--headless"]
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :driver_mobile_iphone6plus_h do |app|
  size = "667,375"
  user_agent = "Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1"
  args = ["--window-size=#{size}", "--use-mobile-user-agent", "--disable-infobars", "--disable-notifications", "--user-agent=#{user_agent}", "--no-sandbox", "--headless"]  
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :driver_ipad_v do |app|
  size = "768,1024"
  user_agent = "Mozilla/5.0 (iPad; CPU OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1"
  args = ["--no-sandbox", "--headless", "--window-size=#{size}", "--use-mobile-user-agent", "--disable-infobars", "--disable-notifications", "--user-agent=#{user_agent}", "--no-sandbox", "--headless"]
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :driver_ipad_h do |app|
  size = "1024,768"
  user_agent = "Mozilla/5.0 (iPad; CPU OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1"
  args = ["--no-sandbox", "--headless", "--window-size=#{size}", "--use-mobile-user-agent", "--disable-infobars", "--disable-notifications", "--user-agent=#{user_agent}", "--no-sandbox", "--headless"]
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :driver_mobile_samsungs6_v do |app|
  size = "360,640"
  user_agent = "Mozilla/5.0 (Linux; Android 6.0.1; SM-G920V Build/MMB29K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.98 Mobile Safari/537.36"
  args = ["--no-sandbox", "--headless", "--window-size=#{size}", "--use-mobile-user-agent", "--disable-infobars", "--disable-notifications", "--user-agent=#{user_agent}", "--no-sandbox", "--headless"]
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :driver_mobile_samsungs6_h do |app|
  size = "640,360"
  user_agent = "Mozilla/5.0 (Linux; Android 6.0.1; SM-G920V Build/MMB29K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/52.0.2743.98 Mobile Safari/537.36"
  args = ["--no-sandbox", "--headless", "--window-size=#{size}", "--use-mobile-user-agent", "--disable-infobars", "--disable-notifications", "--user-agent=#{user_agent}", "--no-sandbox", "--headless"]
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :driver_samsungsTabA_h do |app|
  size = "1024,600"
  user_agent = "Mozilla/5.0 (Linux; Android 5.0.2; SAMSUNG SM-T550 Build/LRX22G) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/3.3 Chrome/38.0.2125.102 Safari/537.36"
  args = ["--no-sandbox", "--headless", "--window-size=#{size}", "--use-mobile-user-agent", "--disable-infobars", "--disable-notifications", "--user-agent=#{user_agent}", "--no-sandbox", "--headless"]
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :driver_mobile_samsungsTabA_v do |app|
  size = "600,1024"
  user_agent = "Mozilla/5.0 (Linux; Android 5.0.2; SAMSUNG SM-T550 Build/LRX22G) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/3.3 Chrome/38.0.2125.102 Safari/537.36"
  args = ["--no-sandbox", "--headless", "--window-size=#{size}", "--use-mobile-user-agent", "--disable-infobars", "--disable-notifications", "--user-agent=#{user_agent}", "--no-sandbox", "--headless"]
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :driver_desktop do |app|
  args = ["--window-size=1280,1696", "--disable-infobars", "--disable-notifications", "--no-sandbox", "--headless"]
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

Capybara.register_driver :driver_mobile_samsungsTabA_v do |app|
  size = "600,1024"
  user_agent = "Mozilla/5.0 (Linux; Android 5.0.2; SAMSUNG SM-T550 Build/LRX22G) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/3.3 Chrome/38.0.2125.102 Safari/537.36"
  args = ["--no-sandbox", "--headless", "--window-size=#{size}", "--use-mobile-user-agent", "--disable-infobars", "--disable-notifications", "--user-agent=#{user_agent}", "--no-sandbox", "--headless"]
  options = Selenium::WebDriver::Chrome::Options.new(args: args)
  Capybara::Selenium::Driver.new(app, {:browser => :chrome, :options => options})
end

