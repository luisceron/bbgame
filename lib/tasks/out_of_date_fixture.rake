# encoding: utf-8
#================================================================================
# This is running inside PredFixture class
#================================================================================
namespace :app do

  desc "Task to unable text_fields after Fixtures Date/hour"
  task out_of_date_fixture: :environment do

    pred_fixtures = Pred::PredFixture.where(out_of_date_time: false)

    pred_fixtures.each do |pred_fixture|
      if pred_fixture.date == Date.today && pred_fixture.hour.hour == Time.now.in_time_zone.hour
        if Time.now.in_time_zone.min >= pred_fixture.hour.min
          pred_fixture.out_of_date_time = true;
          if pred_fixture.save
          	puts "Saved!"
          end
        end
      end
    end
  end

end
