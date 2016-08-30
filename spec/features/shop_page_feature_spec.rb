require 'rails_helper'

feature 'main shop page' do
  scenario 'it displays products on page' do
    prod1 = create(:product)
    prod2 = create(:product)

    visit '/'

    within "div#products" do
      expect(page).to have_content "#{prod1.name}"
      expect(page).to have_content "#{prod2.name}"
    end
  end

  scenario 'adds product to cart' do
    prod = create(:product)

    visit '/'
    click_link "add_to_cart_#{prod.id}"

    within "div#cart" do
      expect(page).to have_content "#{prod.name}"
    end
  end
end
