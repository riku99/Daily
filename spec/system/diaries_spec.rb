require 'rails_helper'

RSpec.describe 'Diaries', type: :system do

  describe 'ユーザーが新しいDiaryを作成する' do
    it 'Diaryが作成される', focus: true do
      visit root_path
      click_link 'create_diary'
      fill_in 'タイトル', with: 'ロッテ戦'
      fill_in 'ないよう', with: 'サークルでロッテの試合を見に行った！勝ってよかった！'
      attach_file '写真を選択する', "#{Rails.root}/spec/images/lotte.jpg"
      expect {
        click_button '作成'
        expect(page).to have_css '.flash'
      }.to change(Diary, :count).by(1)
    end
  end
end
