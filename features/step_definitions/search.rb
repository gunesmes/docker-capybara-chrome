Given("user goes to homepage") do
	visit "/"
	#page.driver.browser.manage.window.maximize
end

When("member selects {string} from search departmant") do |opt_text|
	find(".nav-search-scope.nav-sprite").click()
	options = all("option") 
	options.each do |option|
		option.click() if option.text() == opt_text
	end
end

When("member searches for {string}") do |string|
	fill_in "twotabsearchtextbox", :with => string
	click_on "Go"
end

Then("member should see {string} in filter") do |string|
	expect(find("#s-result-info-bar-content").text).to include(string)
end

Then("member should see the result for {string}") do |string|
	expect(find("#result_0", :match => :first).text).to include(string)
end

When("member navigates to {string} sub-category in {string} from Departmants") do |sub_cat_on_web, cat_on_web|
	find("#nav-shop").hover
	find("span[role='navigation'][aria-label='#{cat_on_web}']").hover()
	
	sub_cats = all(".nav-panel > a > .nav-text")
	sub_cats.each do |cat|
		cat.click() if cat.text() == sub_cat_on_web
		break
	end
end

Then("member should see the {string} bold in head") do |string|
	expect(all("#nav-subnav > a")[0].text).to eq(string)
	expect(all("#nav-subnav > a")[0][:"data-nav-link-bold"]).to eq("1")
end

Then("member should see the following page by clicking the link in head menu") do |table|
	web_items = all("#nav-subnav > a")
	feature_items = table.raw

	web_items.zip(feature_items) { |web_item, feature_item| expect(web_item.text()).to include(feature_item[0]) }
end