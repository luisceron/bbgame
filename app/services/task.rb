class Task < ActiveRecord::Base
  #----------------------------------------------------------------------------
  # Task to check if a Fixture is out of date
  # Params: Nil
  # Return: Nil
  #----------------------------------------------------------------------------
  def self.out_of_date_fixture
    pred_fixtures = Pred::PredFixture.where(out_of_date_time: false)

    pred_fixtures.includes(:fixture).each do |pred_fixture|
      if fixture.date == Date.today && fixture.hour.hour == Time.now.in_time_zone.hour
        if Time.now.in_time_zone.min >= fixture.hour.min
          pred_fixture.update_attribute(:out_ofdate_time, true)
        end
      end
    end
  end
end
