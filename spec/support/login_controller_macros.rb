module LoginControllerMacros
  def login_admin
    before(:each) do
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      admin = FactoryGirl.create(:admin)
      sign_in admin, scope: :admin
    end
  end

  def login_user
    before(:each) do
      @logged_user = FactoryGirl.create(:user)
      @request.env['devise.mapping'] = Devise.mappings[:user]
      sign_in @logged_user
    end
  end
end
