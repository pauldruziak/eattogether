require 'spec_helper'

describe 'A new', Family do
  context 'without name' do
    it 'should be invalid' do
      family = build_stubbed :family, name: nil
      expect(family).to be_invalid
      expect(family.errors.keys).to eq([:name])
    end
  end

  context 'without creator' do
    it 'should be invalid' do
      family = build_stubbed :family, creator: nil
      expect(family).to be_invalid
      expect(family.errors.keys).to eq([:creator_id])
    end
  end

  context 'without event' do
    it 'should be invalid' do
      family = build_stubbed :family, event: nil
      expect(family).to be_invalid
      expect(family.errors.keys).to eq([:event_id])
    end
  end

  context 'without family_members' do
    it 'should be invalid' do
      family = build_stubbed :family, family_members: []
      expect(family).to be_invalid
      expect(family.errors.keys).to eq([:family_members])
    end
  end
end
