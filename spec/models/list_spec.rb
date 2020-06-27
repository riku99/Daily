require 'rails_helper'

RSpec.describe List, type: :model do

  it '有効なファクトリを持つこと' do
    list = FactoryBot.build(:list)
    expect(list).to be_valid
  end

  it 'titleがなければ無効であること' do
    list = FactoryBot.build(:list, title: nil)
    expect(list).to_not be_valid
  end

  it 'priorityがなければ無効であること' do
    list = FactoryBot.build(:list, priority: nil)
    expect(list).to_not be_valid
  end
end
