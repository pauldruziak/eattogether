require 'spec_helper'

describe TransactionPolicy do
  subject { TransactionPolicy.new(user, transaction) }

  context 'for an event where I am participant' do
    let(:user) { build_stubbed :user }
    let(:event) { build_stubbed :event }

    before(:each) do
      allow(event).to receive(:participant?).with(user).and_return(true)
    end

    context 'creating a new transaction' do
      let(:transaction) { event.transactions.build }

      expect_it { to permit(:new) }
      expect_it { to permit(:create) }
    end

    context 'with an transaction that I created' do
      let(:transaction) { build_stubbed :transaction, creator: user, event: event }

      expect_it { to permit(:show)    }
      expect_it { to permit(:edit)    }
      expect_it { to permit(:update)  }
      expect_it { to permit(:destroy) }
    end

    context 'with an transaction someone else created' do
      let(:transaction) { build_stubbed :transaction, creator: build(:user), event: event }

      expect_it { to permit(:show)        }
      expect_it { to_not permit(:edit)    }
      expect_it { to_not permit(:update)  }
      expect_it { to_not permit(:destroy) }
    end
  end

  context 'for an event where I am not participate' do
    let(:user) { build_stubbed :user }
    let(:event) { build_stubbed :event }
    let(:transaction) { event.transactions.build }

    before(:each) do
      allow(event).to receive(:participant?).with(user).and_return(false)
    end

    expect_it { to_not permit(:show)    }
    expect_it { to_not permit(:create)  }
    expect_it { to_not permit(:new)     }
    expect_it { to_not permit(:update)  }
    expect_it { to_not permit(:edit)    }
    expect_it { to_not permit(:destroy) }
  end

  context 'for a visitor' do
    let(:user) { nil }
    let(:transaction) { Transaction.new }

    expect_it { to_not permit(:show)    }
    expect_it { to_not permit(:create)  }
    expect_it { to_not permit(:new)     }
    expect_it { to_not permit(:update)  }
    expect_it { to_not permit(:edit)    }
    expect_it { to_not permit(:destroy) }
  end
end
