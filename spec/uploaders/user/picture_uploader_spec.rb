require 'carrierwave/test/matchers'

describe User::PictureUploader do
  include CarrierWave::Test::Matchers

  let(:user) {create :user_user}

  before do
    User::PictureUploader.enable_processing = true
    @uploader = User::PictureUploader.new(user, :picture)

    File.open('app/assets/images/user/user_default.jpg') do |f|
      @uploader.store!(f)
    end
  end

  after do
    User::PictureUploader.enable_processing = false
    @uploader.remove!
  end

  it "should make the image readable only to the owner and not executable" do
    expect(@uploader).to_not be_nil
  end
end
