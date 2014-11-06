require 'spec_helper'

describe Transaction do
  describe '#creation' do
    it 'creates transaction' do
      expect do
        create :transaction
      end.to change { Transaction.count }.by(1)
    end

    it 'split amount between debtors' do
      debtors = [{ participant_id: 1, selected: true},
                 { participant_id: 2, selected: true},
                 { participant_id: 3, selected: true}]
      transaction = create :transaction, amount: 50, debtors_attributes: debtors
      transaction.reload

      expect(transaction.debtors.count).to eq(3)
      expect(transaction.debtors.map(&:amount).reduce(&:+)).to eq(50.0)
    end

    it 'split amount between payer' do
      payers = [{ participant_id: 1 }, { participant_id: 2 }, { participant_id: 3 }]

      transaction = create :transaction, amount: 50, payers_attributes:payers

      expect(transaction.payers.count).to eq(3)
      expect(transaction.payers.map(&:amount).reduce(&:+)).to eq(50.0)
    end
  end

  describe '#payer_id=' do
    it 'adds payer to #payers list' do
      transaction = build_stubbed :transaction, payer_id: 777

      expect(transaction.payers.size).to eq(1)
    end

    it 'setup specified value as payer#participant_id' do
      transaction = build_stubbed :transaction, payer_id: 777

      expect(transaction.payers.first.participant_id).to eq(777)
    end

    it 'creates new payer' do
      expect do
        create :transaction, payer_id: 777
      end.to change { Payer.count }.by(1)
    end
  end
end
