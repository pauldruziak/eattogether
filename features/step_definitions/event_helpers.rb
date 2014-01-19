def create_event(&block)
  ensure_on new_event_path
  fill_in 'event[title]', with: 'My first event'
  yield block unless block.nil?
  click_on 'Create'
end

def fill_last_participant(with: 'Don')
  all('.ci-participant').last.first('input').set with
end
