require 'spec_helper'

describe User do
  context 'without title' do
    it 'should be invalid' do
      user = build_stubbed :user, name: nil
      expect(user).to be_invalid
      expect(user.errors.keys).to eq([:name])
    end
  end
end
