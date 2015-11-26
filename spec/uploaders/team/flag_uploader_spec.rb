require 'carrierwave/test/matchers'

describe Team::FlagUploader do
  include CarrierWave::Test::Matchers

  let(:team) {create :team_team}

  before do
    Team::FlagUploader.enable_processing = true
    @uploader = Team::FlagUploader.new(team, :flag)

    File.open('app/assets/images/team/default-flag.png') do |f|
      @uploader.store!(f)
    end
  end

  after do
    Team::FlagUploader.enable_processing = false
    @uploader.remove!
  end

  it "should make the image readable only to the owner and not executable" do
    expect(@uploader).to_not be_nil
  end
end
