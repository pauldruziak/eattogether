require 'spec_helper'

describe FamilyPolicy do
  subject { FamilyPolicy.new(user, family) }
  let(:event) { build_stubbed :event }

  context 'for a participate of the event' do
    let(:user) { build_stubbed :user }
    let(:family) { build_stubbed :family, event: event }
    before(:each) { event.participants.create! user_id: user.id, default_name: user.name }

    expect_it { to permit(:show)    }
    expect_it { to permit(:edit)    }
    expect_it { to permit(:update)  }
    expect_it { to permit(:destroy) }
  end

  context 'for not participate of the event' do
    let(:user) { build_stubbed :user }
    let(:family) { build_stubbed :family, event: event }

    expect_it { to_not permit(:show)    }
    expect_it { to_not permit(:edit)    }
    expect_it { to_not permit(:update)  }
    expect_it { to_not permit(:destroy) }
  end

  context 'for a visitor' do
    let(:user) { nil }
    let(:family) { Family.new event: event }

    expect_it { to_not permit(:show)    }
    expect_it { to_not permit(:create)  }
    expect_it { to_not permit(:new)     }
    expect_it { to_not permit(:update)  }
    expect_it { to_not permit(:edit)    }
    expect_it { to_not permit(:destroy) }
  end
end
