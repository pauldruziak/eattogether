require 'spec_helper'

describe EventsController do
  let(:user) { create :user }
  before(:each) { sign_in user }

  describe 'GET #new' do
    it 'respond with success' do
      get :new
      expect(response).to be_success
    end

    it 'renders "new" template' do
      get :new
      expect(response).to render_template('new')
    end

    it 'assigns @event' do
      get :new
      expect(assigns[:event]).to be_kind_of(Event)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:params) { { event: attributes_for(:event) } }

      it 'redirects to show page' do
        post :create, params
        expect(response).to redirect_to(event_path(assigns(:event)))
      end

      it 'creates new event' do
        expect do
          post :create, params
        end.to change { Event.count }
      end

      it 'assigns @event' do
        post :create, params
        expect(assigns(:event)).to be_kind_of(Event)
      end

      it 'assigns current_user as creator of @event' do
        post :create, params
        expect(assigns(:event).creator).to eq(user)
      end
    end

    context 'with invalid params' do
      let(:params) { { event: attributes_for(:event).merge(title: nil) } }

      it 'respond with success' do
        post :create, params
        expect(response).to be_success
      end

      it 'not creates new event' do
        expect do
          post :create, params
        end.to_not change { Event.count }
      end

      it 'renders "new" template' do
        post :create, params
        expect(response).to render_template('new')
      end

      it 'assigns @event' do
        post :create, params
        expect(assigns(:event)).to be_kind_of(Event)
      end

      it 'assigns current_user as creator of @event' do
        post :create, params
        expect(assigns(:event).creator).to eq(user)
      end
    end
  end

  describe 'GET #show' do
    let(:event) { create :event, creator: user }

    it 'respond with success' do
      get :show, id: event.id
      expect(response).to be_success
    end

    it 'renders "show" template' do
      get :show, id: event.id
      expect(response).to render_template('show')
    end

    it 'assigns @event' do
      get :show, id: event.id
      expect(assigns[:event]).to be_kind_of(Event)
    end
  end

  describe 'GET #edit' do
    let(:event) { create :event, creator: user }

    it 'respond with success' do
      get :edit, id: event.id
      expect(response).to be_success
    end

    it 'renders "edit" template' do
      get :edit, id: event.id
      expect(response).to render_template('edit')
    end

    it 'assigns @event' do
      get :edit, id: event.id
      expect(assigns[:event]).to be_kind_of(Event)
    end
  end

  describe 'PATCH #update' do
    let(:event) { create :event, creator: user }

    context 'with valid params' do
      let(:params) { { id: event.id,  event: attributes_for(:event) } }

      it 'redirects to show page' do
        patch :update, params
        expect(response).to redirect_to(event_path(assigns(:event)))
      end

      it 'updates event' do
        patch :update, params
        expect(event.reload.title).to eq(params[:event][:title])
      end

      it 'assigns @event' do
        patch :update, params
        expect(assigns(:event)).to eq(event)
      end
    end

    context 'with invalid params' do
      let(:params) { { id: event.id, event: attributes_for(:event).merge(title: nil) } }

      it 'respond with success' do
        patch :update, params
        expect(response).to be_success
      end

      it 'not updates event' do
        patch :update, params
        expect(event.reload.title).to_not eq(params[:event][:title])
      end

      it 'renders "edit" template' do
        patch :update, params
        expect(response).to render_template('edit')
      end

      it 'assigns @event' do
        patch :update, params
        expect(assigns(:event)).to eq(event)
      end
    end
  end
end
