# docker-capybara-chrome
Run Capybara with Chromedriver in headless mode

Ruby + Capybara + Chrome + Chromedriver

## get the image
    docker pull gunesmes/docker-capybara-chrome

## run the image with executing your tests
    docker run -v /path/to/project:/usr/src/app parallel_cucumber bash -c "cucumber features/M001_head_menu.feature"

or

    docker run -v /path/to/project:/usr/src/app parallel_cucumber bash -c "cucumber features --tag @smoke"
