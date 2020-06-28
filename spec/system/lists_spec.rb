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
          expect(page).to have_css '.flash'
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
          click_button 'Create'
          expect(page).to_not have_content '書類の提出'
          expect(page).to have_css '.error'
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
        expect(page).to have_css '.flash'
      }.to change(List, :count)
    end
  end

  describe 'ユーザーがListを並べ換える' do
    before do
      create_list('First', 'It is first list', '3')
      create_list('Second', 'It is Second list', '1')
      create_list('Third', 'It is third list', '2')
    end
    context '古く作成した順を選んだ場合' do
      it '古く作成した順に並ぶ' do
        visit root_path
        click_link 'Lists'
        click_button '古く作成した順'
        lists = page.all('.lists')
        expect(lists[0].find('.lists_title').text).to eq 'First'
        expect(lists[1].find('.lists_title').text).to eq 'Second'
        expect(lists[2].find('.lists_title').text).to eq  'Third'
      end
    end
    context '新しく作成した順' do
      it '新しく作成した順に並ぶ' do
        visit root_path
        click_link 'Lists'
        click_button '新しく作成した順'
        lists = page.all('.lists')
        expect(lists[0].find('.lists_title').text).to eq 'Third'
        expect(lists[1].find('.lists_title').text).to eq 'Second'
        expect(lists[2].find('.lists_title').text).to eq  'First'
      end
    end
    context '優先順を押した場合' do
      it 'Listのpriority属性を基準に昇順になる',focus: true do
        visit root_path
        click_link 'List'
        click_button '優先順'
        lists = page.all('.lists')
        expect(lists[0].find('.lists_title').text).to eq 'Second'
        expect(lists[1].find('.lists_title').text).to eq 'Third'
        expect(lists[2].find('.lists_title').text).to eq 'First'
      end
    end
  end

end
