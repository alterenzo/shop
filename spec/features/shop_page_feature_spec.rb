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

  scenario 'removes element from a cart' do
    prod = create(:product)

    visit '/'
    click_link "add_to_cart_#{prod.id}"

    within "div#cart" do
      expect(page).to have_content "#{prod.name}"
    end

    click_link "remove_cart_element_#{prod.id}"

    within 'div#cart' do
      expect(page).not_to have_content "#{prod.name}"
    end
  end

  scenario 'increases the quantity if an item is already in the cart' do
    prod = create(:product)

    visit '/'
    click_link "add_to_cart_#{prod.id}"
    click_link "add_to_cart_#{prod.id}"

    within 'div#cart' do
      expect(page).to have_content /.#{prod.name}.2/
    end
  end

  scenario 'does not create another cart element' do
    prod = create(:product)

    visit '/'
    click_link "add_to_cart_#{prod.id}"
    click_link "add_to_cart_#{prod.id}"

    within 'div#cart' do
      expect(page).not_to have_content /.#{prod.name}.#{prod.name}/
    end
  end

  scenario 'shows the total price of items in the cart' do
    prod = create(:product)
    prod1 = create(:product)

    visit '/'
    click_link "add_to_cart_#{prod.id}"
    click_link "add_to_cart_#{prod1.id}"

    within 'div#cart_price_row' do
      expect(page).to have_content "Total: #{prod.price + prod1.price}"
    end
  end

  scenario 'shows a success message if a coupon is applied' do
    prod = create(:product)
    create(:voucher)

    visit '/'
    click_link "add_to_cart_#{prod.id}"
    fill_in 'voucher_code', with: "VOUCHER"
    click_on 'voucher_submit'

    expect(page).to have_content "Coupon Applied!"

  end
end
