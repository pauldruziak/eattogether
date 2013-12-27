require 'spec_helper'

describe EventPolicy do
  subject { EventPolicy.new(user, event) }

  context 'for a user' do
    let(:user) { build_stubbed :user }

    context 'creating a new event' do
      let(:event) { Event.new }

      expect_it { to permit(:new) }
      expect_it { to permit(:create) }
    end

    context "with an event someone else created" do
      let(:event) { build_stubbed :event, creator: build(:user) }

      expect_it { to_not permit(:show)    }
      expect_it { to_not permit(:edit)    }
      expect_it { to_not permit(:update)  }
      expect_it { to_not permit(:destroy) }
    end

    context "with an event that I created" do
      let(:event) { create :event, creator: user }

      expect_it { to permit(:show)    }
      expect_it { to permit(:edit)    }
      expect_it { to permit(:update)  }
      expect_it { to permit(:destroy) }
    end

    context "with an event that I participate" do
      let(:event) { build_stubbed :event, creator: build(:user) }
      before(:each) { event.participants.create! user_id: user.id, default_name: user.name }

      expect_it { to permit(:show)    }
      expect_it { to_not permit(:edit)    }
      expect_it { to_not permit(:update)  }
      expect_it { to_not permit(:destroy) }
    end
  end

  context "for a visitor" do
    let(:user) { nil }
    let(:event) { Event.new }

    expect_it { to_not permit(:show)    }
    expect_it { to_not permit(:create)  }
    expect_it { to_not permit(:new)     }
    expect_it { to_not permit(:update)  }
    expect_it { to_not permit(:edit)    }
    expect_it { to_not permit(:destroy) }
  end
end