Before do |scenario|
	# puts scenario.feature.name 
	@story_name = scenario.location.file 
	
	scenario_tags = scenario.source_tag_names
end


After do |scenario|
	scenario_tags = scenario.source_tag_names

	if scenario.failed?
		puts page.current_url
		embed_exta_info()
		embed_image(scenario.name)
	end
end

def embed_image(name, take_screenshot=true)
	url = page.current_url
	screenshot_path = File.dirname(__FILE__) + '/media/' + name + '.png'

	if take_screenshot
		page.driver.browser.save_screenshot(screenshot_path)
	end
	embed(screenshot_path, "image/png", "SCREENSHOT")
end

def embed_exta_info()
	session_name = Capybara.session_name
	story_name = @story_name
	time_now = Time.now
	current_url = Capybara.current_url.to_s
	run_command = "docker run --name capybara_test -v $PWD:/usr/src/app gunesmes/docker-capybara-chrome:latest bash -c \"cucumber #{story_name} #{session_name}\""

	# Gather browser logs
	logs = page.driver.browser.manage.logs.get(:browser).map {|line| [line.level, line.message]}

	# Remove warnings and info messages
	logs.reject! { |line| ['WARNING', 'INFO'].include?(line.first) }
	logs.any? == true
	

	embed("Time: " + time_now.strftime('%Y-%m-%d-%H-%M-%S' + "\n") + ( "Fail URL: " + current_url + "\n" ) + "Docker Command: " + run_command + "\n\n" + "Brower Error Logs: " + logs.join("\n"), 'text/plain', 'BROWSER ERROR')
end
