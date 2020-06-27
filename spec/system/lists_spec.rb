require 'rails_helper'

RSpec.describe 'Lists', type: :system do

  describe 'ユーザーが新しいListを作成する' do
    context '有効なデータを入力した場合' do
      it 'Listが作成される' do
        visit root_path
        click_link 'Create'
        fill_in 'Title', with: '書類の提出'
        fill_in 'Content', with: '明後日の3時までに書類を提出する'
        fill_in 'Priority', with: 1
        expect {
          click_button 'Create'
          expect(page).to have_content '書類の提出'
          expect(page).to have_content 1
        }.to change(List, :count).by(1)
      end
    end
    context '無効なデータを作成した場合' do
      it 'Listは作成されない' do
        visit root_path
        click_link 'Create'
        fill_in 'Title', with: '書類の提出'
        fill_in 'Content', with: '明後日の3時までに書類を提出する'
        fill_in 'Priority', with: nil
        expect {
          click_link 'Create'
          expect(page).to_not have_content '書類の提出'
        }.to_not change(List, :count)
      end
    end
  end

  describe 'ユーザーがリストを削除する' do
    it 'Listが削除される' do
      visit root_path
      click_link 'Create'
      fill_in 'Title', with: '書類の提出'
      fill_in 'Content', with: '明後日の3時までに書類を提出する'
      fill_in 'Priority', with: 1
      click_button 'Create'
      click_link 'Content'
      expect {
        click_button 'Delete'
        page.driver.browser.switch_to.alert.accept
        expect(page).to_not have_content '書類の提出'
      }.to change(List, :count)
    end
  end

end
