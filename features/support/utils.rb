def assert(args)
  puts "Assertion: #{args}"
  # the third parameter is optional, but default is prefer_exact
  expect(page.has_selector?(args[0].to_sym, args[1], :match => (args[2] || :prefer_exact).to_sym)).to be true
end

def find_by(args)
  # let it wait until loading time
  assert(args)

  # the third parameter is optional, but default is prefer_exact
  page.find(args[0].to_sym, args[1], :match => (args[2] || :prefer_exact).to_sym)
end

def take_screenshot(name)
  screenshot_path = File.dirname(__FILE__) + '/media/' + name + '.png'
  page.driver.browser.save_screenshot(screenshot_path)
end

def wait_until(&block)
  sleep_time = 0.3
  (Capybara.default_max_wait_time / sleep_time).to_i.times do
    break if block_given? && yield
    sleep(sleep_time)
  end
  puts "Block doesnt return true within timeout" if not (block_given? && yield)
  sleep(sleep_time)
end

def dom_ready?
  page.evaluate_script('window.jQuery != undefined')
end

def wait_until_dom_ready()
  wait_until { dom_ready?}
end

def wait_until(&block)
  sleep_time = 0.3
  (Capybara.default_max_wait_time / sleep_time).to_i.times do
    break if block_given? && yield
    sleep(sleep_time)
  end
  puts "Block doesnt return true within timeout" if not (block_given? && yield)
  sleep(sleep_time)
end

def create_dummy_email()
   # time based unique email adress
   make_unique = Time.now.to_i
   email = 'performance.delete.' + make_unique.to_s + '@gmail.com'
end

def has_digits?(str)
   # check if a string icnlude numbers
   str.count("0-9") > 0
end

def dom_ready?
  page.evaluate_script('window.jQuery != undefined')
end

def finished_all_ajax_requests?
  page.evaluate_script('window.jQuery.active').zero?
end

def wait_until_finished_all_ajax_requests
  wait_until_dom_ready()
  wait_until { finished_all_ajax_requests? }
end

def wait_until_selector_ready(selector)
  wait_until_dom_ready
  wait_until { execute_script("return $('#{selector}').size() > 0 ? true : false;") }
end

def check_selector?(selector)
  wait_until_dom_ready
  return execute_script("return $('#{selector}').size() > 0 ? true : false;")
end

def scroll(pixel)
  wait_until_dom_ready
  page.execute_script("window.scrollBy(0, #{pixel})")
end

def scroll_bottom()
  wait_until_dom_ready
  page.execute_script("window.scrollBy(0, $(window).height())")
end

def scroll_top()
  wait_until_dom_ready
  page.execute_script("window.scrollBy(0, 0)")
end

def scroll_to_selector(selector)
  wait_until_dom_ready

  height = page.execute_script("return $('#{selector}').offset().top") - 300
  execute_script("window.scrollTo(0, #{height})")
end

def scroll_to_id(id)
  wait_until_dom_ready

  height = page.execute_script("return $('##{id}').offset().top") - 300
  execute_script("window.scrollTo(0, #{height})")
end

def scroll_to_xpath(xpath)
  wait_until_dom_ready

  script = "return document.evaluate(" + "\"#{xpath}\"" + ", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.offsetTop"
  height = page.execute_script(script) - 300
  execute_script("window.scrollTo(0, #{height})")
end

def scroll_to_element(elem)
  case elem[0]
  when :css
    scroll_to_selector elem[1]
  when :id
    scroll_to_id elem[1]
  when :xpath
    scroll_to_xpath elem[1]  
  end
end

def scroll_to_web_element(element)
  script = <<-JS
    arguments[0].scrollIntoView(true);
  JS
  execute_script(script, element.native)
end

def close_popup()
  evaluate_script("jQuery('.tooltip-close-button').click()")
  find("body").native.send_keys :escape
end

def is_mobile?
  if ENV['DRIVER'].include? "mobile"
    return true  
  else
    return false
  end
end