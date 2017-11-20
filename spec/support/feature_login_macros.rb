module FeatureLoginMacros
  def signin_user
    DatabaseCleaner.clean
    @user ||= FactoryGirl.create(:user)
    login_steps
  end

  private

  def login_steps
    visit '/login'
    within('#new_user') do
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: 'pAssWord123'
    end
    click_button I18n.t(:log_in)
    expect(page).to have_content I18n.t('devise.sessions.signed_in')
    @user
  end
end
