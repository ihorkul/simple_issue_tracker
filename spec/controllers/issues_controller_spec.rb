require 'rails_helper'
RSpec.describe IssuesController, type: :controller do
  describe 'GET #index' do
    it 'redirect for unloged users' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
    describe 'GET #index for loged users' do
      before do
        sign_in create(:user)
        @issue = create(:issue)
      end

      it 'assigns @issues' do
        get :index
        expect(assigns(:issues)).to eq([@issue])
      end

      it 'search isuues with correct params' do
        get :index, params: { search: @issue.key }
        expect(assigns(:issues)).to eq([@issue])
      end

      it 'search isuues with uncorrect params' do
        get :index, params: { search: '111111111111111' }
        expect(assigns(:issues)).to eq([])
      end
    end
  end

  describe 'GET #new' do
    before { get :new }
    it 'assigns a new Issue to @issue' do
      expect(assigns(:issue)).to be_a_new(Issue)
    end

    it 'render view new' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it 'saving with valid data' do
      expect{
        post :create, { params: { issue: attributes_for(:issue) } }
      }.to change{ Issue.count }.by(1)
    end

    it 'not saving with invalid data' do
      expect{
        post :create, { params: { issue: attributes_for(:invalid_issue) } }
      }.to change{ Issue.count }.by(0)
    end
  end

  describe 'GET #show' do
    before do
      @issue = create(:issue)
    end

    it 'redirect for unloged users' do
      get :show, params: { id: @issue.id }
      expect(response).to redirect_to(new_user_session_path)
    end

    describe 'GET #show for signed in users' do
      before do
        @user = create(:user)
        sign_in @user
      end

      it 'Assigned user can leave comment' do
        @issue.update(user_id: @user.id)
        get :show, params: { id: @issue.id }
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it 'correct view rendered' do
        get :show, params: { id: @issue.id }
        expect(response).to render_template :show
      end

      it 'Not assigned user can\'t leave comment' do
        get :show, params: { id: @issue.id }
        expect(assigns(:comment)).to be_nil
      end
    end
  end

  describe 'GET #edit' do
    before do
      @issue = create(:issue)
      get :edit, params: { key: @issue.key }
    end
    it 'assigns @issue' do
      expect(assigns(:issue)).to eq(@issue)
    end

    it 'assigns New comment' do
      expect(assigns(:comment)).to be_a_new(Comment)
    end

    it 'render view edit' do
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    before do
      @issue = create(:issue)
    end

    it 'set flashes after successful saving' do
      put :update, format: :js, params: { id: @issue.id, issue: { subject: 'New subject' } }
      expect(flash[:success]).to be_present
    end

    it 'no flashes after unsuccessful saving' do
      put :update, format: :js, params: { id: @issue.id, issue: { subject: '' } }
      expect(flash[:success]).not_to be_present
    end

    it 'ticket unassigned after update by client' do
      put :update, format: :js, params: { id: @issue.id, issue: { subject: 'New subject' } }
      @issue.reload
      expect(@issue.user_id).to be_nil
    end

    it 'ticket assigns after update by worker' do
      @user = create(:user)
      sign_in @user
      put :update, format: :js, params: { id: @issue.id, issue: { subject: 'New subject' } }
      @issue.reload
      expect(@issue.user_id).to eq(@user.id)
    end
  end
end
