RSpec.shared_examples 'functionality for logged user' do |params|
  if params&.[](:login_before) && params&.[](:visit_path)
    before do
      signin_user
      visit params[:visit_path]
    end
  end

  it 'shoud have shop name link' do
    functionality_steps(I18n.t(:shop_name), root_path)
  end

  it 'should have home link' do
    functionality_steps(I18n.t(:home), root_path)
  end
end
