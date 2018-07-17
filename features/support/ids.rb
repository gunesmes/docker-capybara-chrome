class IDs
	class << self;
		attr_accessor :header, :pages, :containers, :buttons, :selectbox
	end

	# IF DESKTOP
	if not ENV['DRIVER'].include? "mobile"
		@header = {
			"Search"                              => [:css, "#search_word"],
		}
										 
		@containers = {
			"Search List"                         => [:css, "#best-match-right"], 
			"Search Items"                        => [:css, ".products-container > li"], 
			"Search Pages"                        => [:css, 'ul[class="clearfix"]'], 
			"Item Price List Page"                => [:css, 'p[itemprop="price"]'], 
			"Item Price Detail Page"              => [:css, '.product-price-info-con'], 
			"Item Description Detail Page"        => [:css, '#ProductTitle'], 
			"Item Product Id Detail Page"         => [:css, 'input[id="productId"]', :visible => :hidden], 
			"Items Basket"                        => [:css, '.product-item-box'], 
			"Items Title Basket"                  => [:css, '.title-link'], 
		}

		@buttons = {
			"HEADER BUL"                          => [:id, "header_find_button"],
			"Sepete Ekle"                         => [:id, "add-to-basket"],
			"Sepete Devam Et"                     => [:css, "#ContinueToBasket"],
		}

		@selectbox = {
			"color"                               => [:css, 'select[name="ItemSpec"]'],   
		}

	# IF MOBILE    
	else
		@header = {
			"Search"                              => [:css, "#search_word_mobile"],
		}
										 
		@containers = {
			"Search List"                         => [:css, "#best-match-right"], 
			"Search Items"                        => [:css, ".products-container > li"], 
			"Search Pages"                        => [:css, ".next-link"], 
			"Item Price List Page"                => [:css, 'p[itemprop="price"]'], 
			"Item Price Detail Page"              => [:css, '.product-price-info-con'], 
			"Item Description Detail Page"        => [:css, '#ProductTitle'], 
			"Item Product Id Detail Page"         => [:css, 'input[id="productId"]', :visible => :hidden], 
			"Items Basket"                        => [:css, '.product-item-box'], 
			"Items Title Basket"                  => [:css, '.title-link'], 
		}

		@buttons = {
			"HEADER BUL"                          => [:id, "header-mobile-search-find"],
			"Sepete Ekle"                         => [:id, "add-to-basket"],
			"Sepete Devam Et"                     => [:css, "#ContinueToBasket"],
		}

		@selectbox = {
			"color"                               => [:css, 'select[name="ItemSpec"]'],   
		}
	end
end

