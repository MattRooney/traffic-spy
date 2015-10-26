require './test/test_helper'

class IndexPageTest < FeatureTest
  include Capybara::DSL

  def test_user_can_access_index_page
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', payload_data
    post '/sources/jumpstartlab/data', payload_data_two
    visit '/'

    assert page.has_content?("Hello, Traffic Spyer")
    assert page.has_content?("Register")
    assert page.has_content?("View Data & Stats")
    assert page.has_content?("Know your users.")
    assert page.has_content?("© 2015 Keep Slota Wild Inc.")

    within("nav") do
      click_on ("View Data & Stats")
      assert_equal "/data/instructions", current_path
    end

    within("nav") do
      click_on ("Register")
      assert_equal "/register", current_path
    end

    within("footer") do
      click_on ("View Data & Stats")
      assert_equal "/data/instructions", current_path
    end

    within("footer") do
      click_on ("View Data & Stats")
      assert_equal "/data/instructions", current_path
    end
  end
end
