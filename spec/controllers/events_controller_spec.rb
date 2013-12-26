require 'spec_helper'

describe EventsController do
  let(:user) { create :user }
  before(:each) { sign_in user }

  describe 'GET #new' do
    it 'respond with success' do
      get :new
      expect(response).to be_success
    end

    it 'render new.html.slim template' do
      get :new
      expect(response).to render_template('new')
    end

    it 'assign new Event to @event' do
      get :new
      expect(assigns[:event]).to be_kind_of(Event)
    end
  end
end
