require 'spec_helper'

describe 'A new', Event do
  context 'without title' do
    it 'should be invalid' do
      event = build_stubbed :event, title: nil
      expect(event).to be_invalid
      expect(event.errors.keys).to eq([:title])
    end
  end

  context 'without creator' do
    it 'should be invalid' do
      event = build_stubbed :event, creator: nil
      expect(event).to be_invalid
      expect(event.errors.keys).to eq([:creator_id])
    end
  end

  context 'with creator' do
    it 'should add creator to participants' do
      event = create :event, creator_id: create(:user).id
      expect(event.participants.where(user_id: event.creator.id)).to be_exists
    end
  end
end
