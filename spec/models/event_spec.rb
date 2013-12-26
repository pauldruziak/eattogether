require 'spec_helper'

describe Event do
  context 'without title' do
    it 'should be invalid' do
      event = build_stubbed :event, title: nil
      expect(event).to be_invalid
    end
  end
end
