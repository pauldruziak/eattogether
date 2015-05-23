Given(/^я та (.*?) входимо до сім'ї "(.*?)"$/) do |user_name, family_name|
  @family = create :family, event: @event, creator: @user, name: family_name
  other_user = User.find_by_name(user_name)
  @event.participants.where(user_id: [@user.id, other_user.id]).update_all family_id: @family.id
end

Given(/^я на сторінці створення нової сім'ї$/) do
  visit new_event_family_path(@event)
end

Given(/^я обираю користувачів (.*?) для нової сім'ї$/) do |users_name|
  users_name = split_users_name(users_name)
  users_name.each do |name|
    page.check(name)
  end
end

Given(/^ввожу "(.*?)" як ім'я для нової сім'ї$/) do |family_name|
  fill_in "family_name", with: family_name
end

When(/^я натисну "Зберегти" у формі створення сім'ї$/) do
  click_button 'Create'
end

Then(/^маю побачити щойно створенну сім'ю "(.*?)" з корустувачами (.*?)$/) do |family_name, users_name|
  users_name = split_users_name(users_name)
  expect(page.first('.ci-family-name').text).to eq(family_name)
  expect(page.first('.ci-family-members').text.split(', ')).to match_array(users_name)
end
