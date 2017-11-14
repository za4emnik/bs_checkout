RSpec.shared_examples 'functionality for guest' do |params|
  if params&.[](:visit_path)
    before do
      visit params[:visit_path]
    end
  end

  it 'shoud have shop name link' do
    functionality_steps(I18n.t(:shop_name), root_path)
  end

  it 'should have home link' do
    functionality_steps(I18n.t(:home))
  end
end
