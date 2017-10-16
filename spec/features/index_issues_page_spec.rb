require 'rails_helper'

feature 'Index issues page' do
  scenario 'page is not available for not signed in users' do
    visit issues_path
    expect(page.current_path).to eq new_user_session_path
    expect(page).to have_css '.alert.alert-warning'
    expect(page).to have_link 'Login'
    expect(has_no_link?('Issues')).to be_truthy
    expect(page.current_path).to eq new_user_session_path
  end

  context 'page for signed in user' do
    before do
      @user = create(:user)
      login_as @user, scope: :user
    end

    scenario 'showing correct page' do
      visit issues_path
      expect(page).to have_css '.issue_wrapper'
    end

    scenario 'showing correct links' do
      visit issues_path
      expect(page).to have_link 'Issues'
      expect(has_no_link?('Statuses')).to be_truthy
      expect(page).to have_link 'Logout'
    end

    scenario 'showing an issue with default color' do
      create(:issue)
      visit issues_path
      expect(page).to have_css '.panel-default'
    end

    scenario 'showing an issue with primary color' do
      create(:issue, user_id: @user.id)
      visit issues_path
      expect(page).to have_css '.panel-primary'
    end
  end

  context 'page for signed in admin' do
    scenario 'showing correct page' do
      @user = create(:admin)
      login_as @user, scope: :user
      visit issues_path
      expect(page).to have_css '.issue_wrapper'
    end

    scenario 'showing correct links' do
      @user = create(:admin)
      login_as @user, scope: :user
      visit issues_path
      expect(page).to have_link 'Issues'
      expect(page).to have_link 'Statuses'
      expect(page).to have_link 'Logout'
    end
  end
end
