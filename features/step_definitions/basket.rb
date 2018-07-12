Given("I go to home page") do
	visit "/"
	wait_until_selector_ready(IDs.header["Search"][1])
end

When("I search {string}") do |string|
	# if not on the homepage
	if current_path != "/"
		visit "/"
	end

	@search_word = string
	find_by(IDs.header["Search"]).set(string)
	find_by(IDs.buttons["HEADER BUL"]).click()
	wait_until_selector_ready(IDs.containers["Search List"][1])
end

Then("I should see the listed items") do
	wait_until_selector_ready(IDs.containers["Search List"][1])
	scroll_to_element(IDs.containers["Search List"])
	@search_item = page.all(IDs.containers["Search Items"][1])
	expect(@search_item.size).to be > 0
end

When("I go to the page number {int}") do |number|
	scroll_to_element(IDs.containers["Search Pages"])
	if is_mobile?
		(1..number).each do 
			wait_until_selector_ready(IDs.containers["Search Pages"][1])
			scroll_to_element(IDs.containers["Search Pages"][1])
			find_by(IDs.containers["Search Pages"]).click()
		end
	else		
		find_by(IDs.containers["Search Pages"]).find("li:nth-child(#{number})").click()
	end
end

When("I click the item number {int}") do |int|
	scroll_to_web_element(@search_item[int-1])

	# if the each items is composed of multible products 
	if !check_selector?(IDs.containers["Item Price List Page"][1])
		@search_item[int].click()
		
		# now each items should be a single product
		scroll_to_element(IDs.containers["Search List"])
		@search_item = page.all(IDs.containers["Search Items"][0].to_sym, IDs.containers["Search Items"][1])
		expect(@search_item.size).to be > 0
	end	

	# the number of listed items can less then desired
	if @search_item.size < int
		puts "Then number of listed items is less then desired"
		int = @search_item.size
	end
	scroll_to_web_element(@search_item[int-1])
	@item_price = (@search_item[int-1].find(IDs.containers["Item Price List Page"][1]).text).strip()
	@search_item[int-1].click()
end

Then("I should see the listed specific items") do
	steps %Q{
		I should see the listed items
	}
end

When("I click the item number {int} in specific items") do |int|
	if check_selector?(IDs.containers["Item Description Detail Page"][1]) == false
		scroll_to_web_element(@search_item[int])
		@item_price = (@search_item.find(IDs.containers["Item Price List Page"][1]).text).strip()
		@search_item[int].click()
	end
end

Then("I should see the item detail page") do
	expect(find_by(IDs.containers["Item Price Detail Page"]).text).to include(@item_price)

	# we first time come to product detail page
	if @products_info == nil
		@products_info = Hash.new()
	end

	# append new product with search word
	# if we add a new item with same search world, need to add extra control
	@products_info[@search_word] = @item_price
end

When("I click the {string} button") do |string|
	wait_until_dom_ready()
	close_popup()
	
	scroll_to_element(IDs.buttons[string])
	find_by(IDs.buttons[string]).click()
end

When("I select the color number {int}") do |int|
	if check_selector?(IDs.selectbox["color"][1])
		options = find_by(IDs.selectbox["color"])
		scroll_to_web_element(options)
		color_index = int + 1 
		color = options.find("option:nth-child(#{color_index})")[:rel] 
		options.select(color)
	end
end

When("I click the Sepete Devam Et button") do
	if check_selector?(IDs.buttons["Sepete Devam Et"][1])
		find_by(IDs.buttons["Sepete Devam Et"]).click()
	end
end

Then("I should see the item in the basket") do
	wait_until_selector_ready(IDs.containers["Items Basket"][1])
	# @products_info.each { |product| expect(find(".product-items-container").text).to include(product)}
	elements = all(IDs.containers["Items Basket"][1])
	@products_info.each do |search_word, price| 
		elements.each do |el|
			href = el.find(IDs.containers["Items Title Basket"][1])[:href]
			# search word should be in href 
			if href.include? search_word
				expect(el.text).to include(price)		
			end
		end
	end
end

Then("I should see the items in the basket") do
	steps %Q{
		I should see the item in the basket
	} 
end

When("I delete {string} in the basket") do |string|
	elements = all(IDs.containers["Items Basket"][1])
	elements.each do |el|
		href = el.find(IDs.containers["Items Title Basket"][1])[:href]
		if href.include? string
			el.click_on "Sil"

			# need to update the products_info hash too
			@products_info.delete(string)
		end
	end
end