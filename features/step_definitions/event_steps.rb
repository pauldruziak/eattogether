When(/^я спробую створити подію$/) do
  visit new_event_path
end

When(/^я створю подію з вірними даними$/) do
  visit new_event_path
  fill_in 'event[title]', with: 'My first event'
  click_on 'Create'
end

Then(/^я зможу її побачити$/) do
  expect(page).to have_content('My first event')
end
