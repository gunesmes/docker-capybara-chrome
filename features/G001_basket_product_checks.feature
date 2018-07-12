Feature: As a user
	In order to order products
	I want to check the items in the basket

  Background: Member should open homepage
    Given I go to home page       

  @javascript @basket
  Scenario: Member should see exactly the same item in the basket
    When I search "televizyon"
    Then I should see the listed items
    When I go to the page number 2
    Then I should see the listed items
    When I click the item number 5
    Then I should see the item detail page
    When I click the "Sepete Ekle" button
    When I click the Sepete Devam Et button
    Then I should see the item in the basket
    When I search "iphone"
    Then I should see the listed items
    When I click the item number 5
    Then I should see the item detail page
    When I select the color number 1
    When I click the "Sepete Ekle" button
    When I click the Sepete Devam Et button
    Then I should see the items in the basket
    When I delete "televizyon" in the basket
    Then I should see the item in the basket

