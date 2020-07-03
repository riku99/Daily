require 'rails_helper'

RSpec.describe Diary, type: :model do

  it '有効なファクトリがあること' do
    diary = FactoryBot.build(:diary)
    expect(diary).to be_valid
  end

  it 'titleがない場合は無効であること' do
    diary = FactoryBot.build(:diary, title: nil)
    expect(diary).to_not be_valid
  end
end
