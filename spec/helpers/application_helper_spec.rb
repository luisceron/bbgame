RSpec.describe ApplicationHelper, :type => :helper do

  let(:user) {create :user_user}
  let(:team1) {create :team_team}

  before do
    User::PictureUploader.enable_processing = true
    @uploader_user = User::PictureUploader.new(user, :picture)

    File.open('app/assets/images/user/user_default.jpg') do |f|
      @uploader_user.store!(f)
    end
    user.picture = @uploader_user.file
  end

  after do
    User::PictureUploader.enable_processing = false
    @uploader_user.remove!
  end

  before do
    Team::FlagUploader.enable_processing = true
    @uploader_team = Team::FlagUploader.new(team1, :flag)

    File.open('app/assets/images/team/default-flag.png') do |f|
      @uploader_team.store!(f)
    end
    team1.flag = @uploader_team.file
  end

  after do
    Team::FlagUploader.enable_processing = false
    @uploader_team.remove!
  end

  describe "application helper" do
    it "returns the default picture" do
	    display_picture(user, 10, 10, "")
    end

    it "returns the default flag" do
      display_flag(team1, 10, 10, "")
    end
  end

end
