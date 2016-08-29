require 'rails_helper'

feature 'main shop page' do
  scenario 'it displays products on page' do
    create(:product)

    visit '/'

    expect(page).to have_content "Product1"
  end
end
