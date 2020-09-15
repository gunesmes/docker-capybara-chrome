[![Docker run for parallel execution](https://img.youtube.com/vi/Nd4kGeQeJgk/maxresdefault.jpg)](https://youtu.be/Nd4kGeQeJgk "Docker Run for Parallel Execution")

## Test Setup

Basic test base setup with cucumber, capybara, selenium, rspec and poltergeist.

First thing to do is installing ruby or jruby. You can do this by using rbenv or rvm or default system installations (brew, apt-get, yum, etc)
    
### Install Brew    
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    
### Install rbenv    
    brew install rbenv

### Install Latest Ruby
    rbenv install --list --> find latest Ruby version
    
    rbenv install 2.4.0

For Windows:
	download installer: http://rubyinstaller.org/downloads/


### Install Bundler
	gem install bundler

### Clone the project into project folder
    mkdir ~/project
    cd ~/project
    git clone https://gitlab.com/gunesmes/cucumber_capybara_responsive_docker_sample.git

### install Capybara required gems
    cd ~/project/cucumber_capybara_responsive_docker_sample
    bundle install

### install chromedriver
    brew install chromedriver

And then create your tests by following the example and run them as below:

    bundle exec cucumber features

or simply

    cucumber features DRIVER=chrome --profile=html_report

### Run
#### Visual Run for mobile iPhone6
    cucumber features/G001_basket_product_checks.feature DRIVER=driver_mobile_iphone6_v_visible

#### Visual Run for Desktop
    cucumber features/G001_basket_product_checks.feature DRIVER=driver_chrome

#### Docker run for a single tag with single platform
    docker run --shm-size 128M --rm --name capybara_m -v $PWD:/usr/src/app gunesmes/docker-capybara-chrome:latest bash -c "cucumber features/G001_basket_product_checks.feature DRIVER=driver_desktop"

#### Docker run for parallel execution of smoke test 
    bash run.sh

check the reports inside the ./html_report

#### Docker run for parallel execution of all tags with all platforms
    bash run_full.sh

create report form json report in ./report folder

