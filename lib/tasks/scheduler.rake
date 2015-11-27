desc "This task is called by the Heroku scheduler add-on"
task :check_fixtures_out_of_date => :environment do
  Pred::PredFixture.out_of_date_fixture
end
