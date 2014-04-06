Given(/^я увійшов у систему$/) do
  @user = create :user
  ensure_on new_user_session_path
  fill_in 'user[email]', with: @user.email
  fill_in 'user[password]', with: @user.password
  click_on 'Sign in'
end

Given(/^гість вирішив зареєструватись за допомогою email та паролю$/) do
  visit '/users/sign_up'
end

When(/^він відправить свої дані$/) do
  fill_in 'user[name]', with: 'James Bond'
  fill_in 'user[email]', with: 'james.bond@example.com'
  fill_in 'user[password]', with: 'password'
  fill_in 'user[password_confirmation]', with: 'password'
  click_on 'Sign up'
end

Then(/^має отримати лист з привітанням про успішну реєстрацію$/) do
  open_email('james.bond@example.com')
  expect(current_email.subject).to eq I18n.t('devise.mailer.signed_up')
end

Then(/^опинитися в середині системи$/) do
  expect(page).to have_content('Sign Out')
end
