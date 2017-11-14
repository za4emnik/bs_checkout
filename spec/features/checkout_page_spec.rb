require 'rails_helper'

describe 'checkout page', type: :feature do
  include ApplicationHelper

  context 'index page' do
    context 'when logged' do
      before do
        signin_user
        add_book_to_cart
        visit bs_checkout_path
      end

      it_behaves_like 'functionality for logged user'

      it 'should redirect to address step if click checkout button' do
        click_button('Checkout', match: :first)
        expect(current_path).to eq(bs_checkout.checkout_path(:address))
      end
    end

    context 'when guest' do
      before do
        add_book_to_cart
        visit bs_checkout_path
      end

      it_behaves_like 'functionality for guest'

      it 'should redirect to login page if click checkout button' do
        click_button(I18n.t(:checkout), match: :first)
        expect(current_path).to eq(new_user_session_path)
      end
    end

    context 'when logged or guest' do
      context 'when have items' do
        before do
          add_book_to_cart
          visit bs_checkout_path
        end

        it 'should have product' do
          expect(page).to have_content(I18n.t(:product))
        end

        it 'should have price' do
          expect(page).to have_content(I18n.t(:price))
        end

        it 'should have quantity' do
          expect(page).to have_content(I18n.t(:quantity))
        end

        it 'should have subtotal' do
          expect(page).to have_content(I18n.t(:subtotal))
        end
      end

      context 'when cart is empty' do
        before do
          visit bs_checkout_path
        end

        it 'should show empty message' do
          expect(page).to have_content(I18n.t(:cart_empty))
        end
      end
    end
  end

  describe 'address step' do
    context 'when logged' do
      before do
        signin_user
        add_book_to_cart
        visit bs_checkout.checkout_path(:address)
      end

      it_behaves_like 'functionality for logged user'

      it 'should contain shipping address' do
        expect(page).to have_content(I18n.t(:shipping_address))
      end

      it 'should contain billing address' do
        expect(page).to have_content(I18n.t(:billing_address))
      end

      it 'should have continue button' do
        expect(page).to have_button(I18n.t(:save_and_continue))
      end
    end

    context 'when guest' do
      before do
        add_book_to_cart
        visit bs_checkout.checkout_path(:address)
      end

      it 'should redirect to login page' do
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe 'delivery step' do
    context 'when logged' do
      before do
        signin_user
        add_book_to_cart
        visit bs_checkout.checkout_path(:delivery)
      end

      it_behaves_like 'functionality for logged user'

      it 'should contain method' do
        expect(page).to have_content(I18n.t(:method))
      end

      it 'should contain days' do
        expect(page).to have_content(I18n.t(:days))
      end

      it 'should contain price' do
        expect(page).to have_content(I18n.t(:price))
      end

      it 'should have continue button' do
        expect(page).to have_button(I18n.t(:save_and_continue))
      end
    end

    context 'when guest' do
      before do
        add_book_to_cart
        visit bs_checkout.checkout_path(:delivery)
      end

      it 'should redirect to login page' do
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe 'payment step' do
    context 'when logged' do
      before do
        signin_user
        add_book_to_cart
        visit bs_checkout.checkout_path(:payment)
      end

      it_behaves_like 'functionality for logged user'

      it 'should contain card number' do
        expect(page).to have_field(I18n.t(:card_number))
      end

      it 'should contain name on card' do
        expect(page).to have_field(I18n.t(:name_on_card))
      end

      it 'should contain validity' do
        expect(page).to have_field(I18n.t(:date_format))
      end

      it 'should contain cvv' do
        expect(page).to have_field(I18n.t(:cvv))
      end

      it 'should have continue button' do
        expect(page).to have_button(I18n.t(:save_and_continue))
      end
    end

    context 'when guest' do
      before do
        add_book_to_cart
        visit bs_checkout.checkout_path(:delivery)
      end

      it 'should redirect to login page' do
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe 'confirm step' do
    context 'when logged' do
      before do
        signin_user
        add_book_to_cart
        go_to_step(:confirm)
      end

      it_behaves_like 'functionality for logged user'

      it 'should contain shipping address' do
        expect(page).to have_content(I18n.t(:shipping_address))
      end

      it 'should contain billing address' do
        expect(page).to have_content(I18n.t(:billing_address))
      end

      it 'should contain shipments' do
        expect(page).to have_content(I18n.t(:shipments))
      end

      it 'should contain payment information' do
        expect(page).to have_content(I18n.t(:payment_information))
      end

      it 'should have place order' do
        expect(page).to have_button(I18n.t(:place_order))
      end
    end

    context 'when guest' do
      before do
        add_book_to_cart
        visit bs_checkout.checkout_path(:confirm)
      end

      it 'should redirect to login page' do
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end

  describe 'complete step' do
    context 'when logged' do
      before do
        signin_user
        add_book_to_cart
        go_to_step(:complete)
      end

      it_behaves_like 'functionality for logged user'

      it 'should contain thanks message' do
        expect(page).to have_content(I18n.t(:thank_for_order))
      end

      it 'should have back to store button' do
        expect(page).to have_button(I18n.t(:back_to_store))
      end

      it 'should redirect to categories page if click back to store button' do
        click_button(I18n.t(:back_to_store))
        expect(current_path).to eq(root_path)
      end
    end

    context 'when guest' do
      before do
        add_book_to_cart
        visit bs_checkout.checkout_path(:complete)
      end

      it 'should redirect to login page' do
        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end
