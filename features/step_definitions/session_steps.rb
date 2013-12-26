Given /^я не авторизований користувач$/ do
end

Then(/^маю побачити сторінку авторизації$/) do
  expect(current_path).to eq(new_user_session_path)
end
