Given(/^я увійшов у систему$/) do
  @user = create :user, name: 'Паша'
  login_as @user
end

Given(/^гість вирішив зареєструватись за допомогою email та паролю$/) do
  visit '/users/sign_up'
end

Given(/^користувач вже зареєстрований у системі$/) do
  @user = create :user
end

When(/^він відправить свої дані для реєстрації$/) do
  fill_in 'user[name]', with: 'James Bond'
  fill_in 'user[email]', with: 'james.bond@example.com'
  fill_in 'user[password]', with: 'password'
  fill_in 'user[password_confirmation]', with: 'password'
  click_on 'Sign up'
end

When(/^він відправить свої дані для авторизації$/) do
  login_as @user
end

When(/^він скористався можливістю відновити пароль$/) do
  ensure_on new_user_session_path
  click_on 'Forgot your password?'
  fill_in 'user[email]', with: @user.email
  click_on 'Send me reset password instructions'
end

Then(/^має отримати лист з привітанням про успішну реєстрацію$/) do
  open_email 'james.bond@example.com'
  expect(current_email.subject).to eq I18n.t('devise.mailer.signed_up.subject')
end

Then(/^має опинитися в середині системи$/) do
  expect(page).to have_content('Sign Out')
end

Then(/^має отримати лист з інструкціями по відновленню паролю$/) do
  open_email @user.email
  expect(current_email.subject).to eq I18n.t('devise.mailer.reset_password_instructions.subject')
end
