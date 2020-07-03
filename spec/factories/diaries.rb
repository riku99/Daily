FactoryBot.define do
  factory :diary do
    title { '野球観戦' }
    content { '勝ってよかった！' }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/images/lotte.jpg')) }
  end
end
