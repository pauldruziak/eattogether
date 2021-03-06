Given(/^що я учасником певної події$/) do
  participants = [{ default_name: @user.name, user_id: @user.id }]
  @event = create :event, participants_attributes: participants
end

Given(/^що я не є учасником певної події$/) do
  @event = create :event
end

Given(/^в мене є подія$/) do
  @bob = create :user, name: 'Bob'
  @kate = create :user, name: 'Kate'
  participants = [
    { default_name: @bob.name, user_id: @bob.id },
    { default_name: @kate.name, user_id: @kate.id }
  ]
  @event = create :event, creator: @user, participants_attributes: participants
end

Given(/^в мене є подія з користувачими (.*?)$/) do |users_name|
  users_name = split_users_name(users_name)
  participants = users_name.map do |user_name|
    { default_name: user_name, user_id: create(:user, name: user_name).id }
  end
  @event = create :event, creator: @user, participants_attributes: participants
end

When(/^я спробую створити подію$/) do
  ensure_on new_event_path
end

When(/^я спробую переглянути будь\-яку подію$/) do
  event = create :event
  visit event_path(event)
end

When(/^я спробую переглянути цю подію$/) do
  visit event_path(@event)
end

When(/^я відкрию сторінку балансу для цієї події$/) do
  visit event_path(@event)
end

When(/^я створю подію з вірними даними$/) do
  create_event
end

When(/^під час створення події я вкажу лише імена учасників$/) do
  create_event do
    fill_last_participant with: 'Maria'
    click_on 'Add an participant'
    fill_last_participant with: 'Dave'
  end
end

When(/^я внесу трату в цю подію$/) do
  ensure_on event_path(@event)

  click_on 'New transaction'
  fill_form :transaction, @bob.name => true, @user.name => true, amount: '10'
  click_on submit(:transaction)
end

Then(/^я зможу її побачити$/) do
  expect(page).to have_content('My first event')
end

Then(/^будуть створенні "віртуальні" учасники$/) do
  expect(page).to have_content('My first event')
  expect(page).to have_content(@user.name)
  expect(page).to have_content('Maria')
  expect(page).to have_content('Dave')
end

Then(/^побачу наступний баланс:$/) do |table|
  expected_balance =  table.rows_hash.to_a
  current_balance = find('ul.balance').all('li').map do |row|
    amount = row.find('.badge').text
    name = row.text.gsub(amount, '')
    [name, amount]
  end
  expect(current_balance).to match_array(expected_balance)
end
