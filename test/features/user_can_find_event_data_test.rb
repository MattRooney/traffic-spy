require './test/test_helper'

class EventPageTest < FeatureTest
  include Capybara::DSL

  def test_user_can_find_event_details
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', payload_data
    post '/sources/jumpstartlab/data', payload_data_two
    visit '/sources/jumpstartlab/events'

    assert page.has_content?("Events Index!")
    assert page.has_content?("Hyperlinks of each URL:")
    assert page.has_content?("socialLogin")
    assert page.has_content?("© 2015 Keep Slota Wild Inc.")

    click_on("socialLogin") do
      assert_equal "/sources/jumpstartlab/events/socialLogin", current_path

      assert page.has_content?("Events Details!")
      assert page.has_content?("Total times event received:")
    end
  end
end
