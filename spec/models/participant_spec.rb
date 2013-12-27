require 'spec_helper'

describe Participant do
  context 'without default_name' do
    it 'should be invalid' do
      participant = build_stubbed :participant, default_name: nil
      expect(participant).to be_invalid
      expect(participant.errors.keys).to eq([:default_name])
    end
  end

  context 'without event_id' do
    it 'should be invalid' do
      participant = build_stubbed :participant, event: nil
      expect(participant).to be_invalid
      expect(participant.errors.keys).to eq([:event_id])
    end
  end
end
