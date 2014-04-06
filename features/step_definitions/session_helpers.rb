def login_as(user)
  ensure_on new_user_session_path
  fill_in 'user[email]', with: @user.email
  fill_in 'user[password]', with: @user.password
  click_on 'Sign in'
end
