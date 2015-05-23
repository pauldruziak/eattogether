require 'spec_helper'

describe FamiliesController do
  let(:user) { create :user }
  let(:event) { create :event, creator: user }
  let(:participant) { create :participant, event: event }
  let(:valid_attributes) do
    {
      "name" => "Family Name",
      "family_members_attributes" => { "0" => { "id" => participant.id, "selected" => "1"} }
    }
  end

  before(:each) { sign_in user }


  describe "GET index" do
    it "assigns all families as @families" do
      family = create :family, valid_attributes.merge(creator: user, event: event)
      get :index, { event_id: event.id }
      assigns(:families).should eq([family])
    end
  end

  describe "GET new" do
    it "assigns a new family as @family" do
      get :new, { event_id: event.id }
      assigns(:family).should be_a_new(Family)
    end

    it "assigns participants without family as @available_participants" do
      get :new, { event_id: event.id }
      assigns(:available_participants).should eq(event.participants.without_family)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Family" do
        expect {
          post :create, { event_id: event.id, :family => valid_attributes }
        }.to change(Family, :count).by(1)
      end

      it "assigns a newly created family as @family" do
        post :create, { event_id: event.id, :family => valid_attributes }
        assigns(:family).should be_a(Family)
        assigns(:family).should be_persisted
      end

      it "redirects to the created family" do
        post :create, { event_id: event.id, :family => valid_attributes }
        response.should redirect_to(event_families_path(event))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved family as @family" do
        Family.any_instance.stub(:save).and_return(false)
        post :create, { event_id: event.id, :family => { "name" => "invalid value" } }
        assigns(:family).should be_a_new(Family)
      end

      it "re-renders the 'new' template" do
        Family.any_instance.stub(:save).and_return(false)
        post :create, { event_id: event.id, :family => { "name" => "invalid value" } }
        response.should render_template("new")
      end
    end
  end

  describe "DELETE destroy" do
    let!(:family) { create :family, valid_attributes.merge(creator: user, event: event) }

    it "destroys the requested family" do
      expect {
        delete :destroy, {:id => family.to_param}
      }.to change(Family, :count).by(-1)
    end

    it "redirects to the families list" do
      delete :destroy, {:id => family.to_param}
      response.should redirect_to(event_families_path(event))
    end
  end

end
