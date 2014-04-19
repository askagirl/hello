
  def given_I_have_a_password_identity
    Hello::Identity.create! strategy: Hello::Identity.password,
                            user:     Hello::User.create(name: 'James Pinto'),
                            email:    'foo@bar.com',
                            username: 'foobar',
                            password: 'foobar'
  end

  def given_I_am_logged_in
    when_sign_up_with_standard_data
    when_sign_in_with_standard_data
    then_I_should_be_logged_in
  end

  def when_I_ask_to_reset_my_password(custom_login=nil)
    visit hello.root_path
    click_link "Forgot"
    within("form") do
      fill_in 'login', with: (custom_login || 'foobar')
    end
    click_button 'Ask to reset my password'
  end

  def when_sign_up_with_standard_data
    visit hello.root_path
    within("form") do
      fill_in 'name',     with: 'James Pinto'
      fill_in 'email',    with: 'foo@bar.com'
      fill_in 'username', with: 'foobar'
      fill_in 'password', with: 'foobar'
    end
    click_button 'Sign Up'
  end

  def when_sign_in_with_standard_data(custom_password=nil)
    visit hello.root_path
    click_link "Sign In"
    within("form") do
      fill_in 'login',    with: 'foobar'
      fill_in 'password', with: (custom_password || 'foobar')
    end
    click_button 'Sign In'
  end

  def then_I_should_be_logged_in
    expect(page).to have_content "Hello, James Pinto!"
    expect(page).to have_content "Sign Out"
  end

  def then_I_should_not_be_logged_in
    expect(page).to have_content "Hello, Guest!"
  end



