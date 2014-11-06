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

describe Event do
  describe '#participants_without_owner' do
    it 'returns all participants without owner' do
      event = create :event, participants_attributes: [{ default_name: 'John' }]

      expect(event.participants.map(&:display_name)).to match_array([event.creator.name, 'John'])
      expect(event.participants_without_owner.map(&:display_name)).to eq(['John'])
    end
  end

  describe '#participant?' do
    let(:user) { create :user }
    let(:other_user) { create :user }
    let(:participants) { [{ default_name: user.name, user_id: user.id }] }
    let(:event) { create :event, participants_attributes: participants }

    it 'returns true if user listed in participants' do
      expect(event.participant?(user)).to be_true
    end

    it 'returns false if user not listed in participants' do
      expect(event.participant?(other_user)).to be_false
    end
  end
end
