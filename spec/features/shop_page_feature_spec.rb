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

  scenario 'shows an error message if a coupon is not found' do
    prod = create(:product)
    create(:voucher)

    visit '/'
    click_link "add_to_cart_#{prod.id}"
    fill_in 'voucher_code', with: "INVALIDVOUCHER"
    click_on 'voucher_submit'

    expect(page).to have_content "Voucher must exist"
  end

  scenario 'applies discount on the final price' do
    prod = create(:product, price: 10.00)
    create(:voucher,code: "CODE", discount_amount: 5.00)

    visit '/'
    click_link "add_to_cart_#{prod.id}"
    fill_in 'voucher_code', with: "CODE"
    click_on 'voucher_submit'

    expect(page).to have_content "Discount: -5.0"
    expect(page).to have_content "Final Price: 5.0"
  end

  scenario 'does not apply discount if minimum spend condition is not met' do
    prod = create(:product, price: 10.00)
    create(:voucher,code: "CODE", discount_amount: 5.00, min_amount: 50)

    visit '/'
    click_link "add_to_cart_#{prod.id}"
    fill_in 'voucher_code', with: "CODE"
    click_on 'voucher_submit'

    expect(page).to have_content "You must spend at least £50.0 to use this coupon"
  end

  scenario 'cart does not include required category for coupon' do
    prod = create(:product, price: 10.00)
    required_cat = create(:category, name: "required category")
    voucher = create(:voucher, code: "CODE", discount_amount: 5 )
    voucher.categories << required_cat

    visit '/'
    click_link "add_to_cart_#{prod.id}"
    fill_in 'voucher_code', with: "CODE"
    click_on 'voucher_submit'

    expect(page).to have_content "At least one item from required category is needed"
  end

  scenario 'a voucher is removed if requirements are not met after removing a product' do
    prod = create(:product, price: 10.00)
    voucher = create(:voucher, code: "CODE", discount_amount: 5, min_amount: 15.00 )

    visit '/'
    click_link "add_to_cart_#{prod.id}"
    click_link "add_to_cart_#{prod.id}"
    fill_in 'voucher_code', with: "CODE"
    click_on 'voucher_submit'

    expect(page).to have_content "Coupon Applied!"
    expect(page).to have_content "Discount:"

    click_link"remove_cart_element_#{prod.id}"

    expect(page).not_to have_content "Discount:"
  end
end
