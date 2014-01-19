require 'spec_helper'

FactoryGirl.factories.each do |factory|
  describe "The #{factory.name} factory" do
    it 'build valid record' do
      expect(build_stubbed factory.name).to be_valid
    end
  end
end
