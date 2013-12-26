Given(/^я увійшов у систему$/) do
  @user = create :user
  visit new_user_session_path
  fill_in 'user[email]', with: @user.email
  fill_in 'user[password]', with: @user.password
  click_on 'Sign in'
end

Then(/^маю побачити сторінку авторизації$/) do
  expect(current_path).to eq(new_user_session_path)
end
