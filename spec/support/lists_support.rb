module ListsSupport

  def create_list(title, content, priority)
    visit root_path
    click_link 'リスト作成'
    fill_in 'Title', with: title
    fill_in 'Content', with: content
    fill_in 'Priority', with: priority
    click_button 'Create'
  end
end

RSpec.configure do |config|
  config.include ListsSupport
end
