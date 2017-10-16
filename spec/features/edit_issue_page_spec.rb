require 'rails_helper'

feature 'Edit issue page' do
  context 'test plans not available' do
    before do
      @issue = create(:issue)
      visit edit_issue_path(@issue.key)
    end

    scenario 'showing an error after invalid update', js: true do
      within('.edit_issue') do
        fill_in 'issue_subject', with: ''
      end
      click_button 'Update Issue'
      expect(page).to have_content 'error'
    end

    scenario 'showing a flash after successful update', js: true do
      within('.edit_issue') do
        fill_in 'issue_subject', with: 'Subject 3'
      end
      click_button 'Update Issue'
      expect(page).to have_content 'success'
    end

    scenario 'showing an error after invalid update', js: true do
      within('.new_comment') do
        fill_in 'comment_text', with: ''
      end
      click_button 'Send'
      expect(page).to have_content 'error'
    end

    scenario 'showing a flash after successful update', js: true do
      within('.new_comment') do
        fill_in 'comment_text', with: 'Comment'
      end
      click_button 'Send'
      expect(page).to have_content 'success'
    end

    scenario 'showing comment after successful update', js: true do
      within('.new_comment') do
        fill_in 'comment_text', with: 'My new app'
      end
      click_button 'Send'
      row_comments = find('.row.comments')
      expect(row_comments).to have_content 'app'
      expect(row_comments).to have_content @issue.email
    end
  end
end
