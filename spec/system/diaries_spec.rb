require 'rails_helper'

RSpec.describe 'Diaries', type: :system do

  describe 'ユーザーが新しいDiaryを作成する' do
    context '有効なデータの場合' do
      it 'Diaryが作成される' do
        visit root_path
        click_link '日記作成'
        fill_in 'タイトル', with: 'ロッテ戦'
        fill_in 'ないよう', with: 'サークルでロッテの試合を見に行った！勝ってよかった！'
        attach_file '写真を選択する', "#{Rails.root}/spec/images/lotte.jpg", make_visible: true
        expect {
          click_button '作成'
          expect(page).to have_css '.flash'
        }.to change(Diary, :count).by(1)
      end
    end
    context '無効なデータの場合' do
      it 'Diaryは作成されない' do
        visit root_path
        click_link '日記作成'
        fill_in 'タイトル', with: nil
        fill_in 'ないよう', with: 'いい試合だった！'
        expect {
          click_button '作成'
          expect(page).to have_css '.error'
        }
      end
    end
  end

  describe 'ユーザーがDiaryを削除する' do
    before do
      FactoryBot.create(:diary)
    end
    it 'Diaryが削除される' do
      visit root_path
      click_link '日記を読む'
      click_button '1'
      click_link '野球観戦'
      expect {
        click_button '削除する'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_css '.flash'
      }.to change(Diary, :count)
    end
  end

  describe 'ユーザーがページ番号を押してページを変える' do
    before do
      i = 1
      while i <= 13 do
        FactoryBot.create(:diary, title: "野球観戦#{i}")
        i += 1
      end
    end
    it 'それぞれ6要素ずつ適切なDiaryが表示される' do
      visit root_path
      click_link '日記を読む'
      click_button '1'
      expect(page).to have_content '野球観戦13'
      expect(page).to have_content '野球観戦8'
      click_button '2'
      expect(page).to have_content '野球観戦7'
      expect(page).to have_content '野球観戦2'
      click_button '3'
      expect(page).to have_content '野球観戦1'
    end
  end
end
