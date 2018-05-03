# docker-capybara-chrome
Run Capybara with Chromedriver in headless mode

Ruby + Capybara + Chrome + Chromedriver

## get the image
    docker pull gunesmes/docker-capybara-chrome

## run the image with executing your tests
    docker run -v /path/to/project:/usr/src/app parallel_cucumber bash -c "cucumber features/M001_head_menu.feature"

or

    docker run -v /path/to/project:/usr/src/app parallel_cucumber bash -c "cucumber features --tag @smoke"


## set headless driver in your env.rb file

Ensure that you have chromedriver headless in your `env.rb`, you can set it as below:

    Capybara.register_driver :chrome_headless do |app|
      args = ["--window-size=1280,1696", "--disable-infobars", "--disable-notifications", "--no-sandbox", "--headless", "--disable-gpu"]  
      Capybara::Selenium::Driver.new(app, {:browser => :chrome, :args => args})
    end

    Capybara.default_driver = :chrome_headless
    Capybara.javascript_driver = :chrome_headless


## simpliest running the tags in run.sh

Ensure that you are in the project folder, and the path in run.sh is correct

	~/d/simple_capybara (master ⚡) sh run.sh
	 - Running tests with tagged: search
	 - Running tests with tagged: navigate-video

	 - All processes done!
	 - 0 minutes and 28 seconds elapsed.

