require 'spec_helper'

describe EventsHelper do
  describe 'group_by_family' do
    it 'group participants by family name' do
      participants = [
        double('participant1', family_name: 'foo', amount: 10),
        double('participant2', family_name: 'foo', amount: 10),
        double('participant3', family_name: 'bar', amount: 10)
      ]
      expect(helper.group_by_family(participants)).to eq({ 'foo' => '20.00', 'bar' => '10.00' })
    end
  end
end
