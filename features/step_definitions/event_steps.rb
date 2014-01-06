Given(/^що я учасником певної події$/) do
  participants = [{ default_name: @user.name, user_id: @user.id }]
  @event = create :event, participants_attributes: participants
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

Then(/^я зможу її побачити$/) do
  expect(page).to have_content('My first event')
end

Then(/^будуть створенні "віртуальні" учасники$/) do
  expect(page).to have_content('My first event')
  expect(page).to have_content(@user.name)
  expect(page).to have_content('Maria')
  expect(page).to have_content('Dave')
end
