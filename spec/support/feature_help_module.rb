module FeatureHelpModule
  def functionality_steps(content, expected_path = nil)
    expect(page).to have_link(content, match: :first)
    if expected_path
      click_link(content, match: :first)
      expect(current_path).to eql(expected_path)
    end
  end

  def add_book_to_cart
    product = FactoryGirl.create(:product)
    visit book_path(product)
    click_button I18n.t(:add_to_cart)
  end

  def go_to_step(step)
    steps = %i[address delivery payment confirm complete]
    visit bs_checkout.checkout_path(:address)
    steps[0...steps.index(step)].each do |current_step|
      expect(current_path).to eq(bs_checkout.checkout_path(current_step))
      send(current_step)
    end
    expect(current_path).to eq(bs_checkout.checkout_path(step))
  end

  private

  def address
    country = FactoryGirl.create(:country)
    address = FactoryGirl.attributes_for(:order_shipping_address)
    visit bs_checkout.checkout_path(:address)
    within '#new_address_form' do
      fill_in 'address_form[billing_form][first_name]', with: address[:first_name]
      fill_in 'address_form[billing_form][last_name]', with: address[:last_name]
      fill_in 'address_form[billing_form][address]', with: address[:address]
      fill_in 'address_form[billing_form][city]', with: address[:city]
      fill_in 'address_form[billing_form][zip]', with: address[:zip]
      fill_in 'address_form[billing_form][phone]', with: address[:phone]
      select country.name, from: 'address_form[billing_form][country_id]'

      fill_in 'address_form[shipping_form][first_name]', with: address[:first_name]
      fill_in 'address_form[shipping_form][last_name]', with: address[:last_name]
      fill_in 'address_form[shipping_form][address]', with: address[:address]
      fill_in 'address_form[shipping_form][city]', with: address[:city]
      fill_in 'address_form[shipping_form][zip]', with: address[:zip]
      fill_in 'address_form[shipping_form][phone]', with: address[:phone]
      select country.name, from: 'address_form[shipping_form][country_id]'
      click_button(I18n.t(:save_and_continue), match: :first)
    end
  end

  def delivery
    order = BsCheckout::Order.first
    order.delivery = FactoryGirl.create(:delivery)
    order.save
    visit bs_checkout.checkout_path(:payment)
  end

  def payment
    credit_card = FactoryGirl.attributes_for(:credit_card)
    visit bs_checkout.checkout_path(:payment)
    within '#new_credit_card_form' do
      fill_in 'credit_card_form[number]', with: credit_card[:number]
      fill_in 'credit_card_form[name]', with: credit_card[:name]
      fill_in 'credit_card_form[date]', with: credit_card[:date]
      fill_in 'credit_card_form[cvv]', with: credit_card[:cvv]
      click_button(I18n.t(:save_and_continue), match: :first)
    end
  end

  def confirm
    click_button(I18n.t(:place_order), match: :first)
  end
end
