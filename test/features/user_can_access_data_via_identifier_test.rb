require './test/test_helper'

class IdentifierViewTest < FeatureTest
  include Capybara::DSL

  def test_user_can_view_their_own_identifier_page
    populate_sources
    post '/sources/jumpstartlab/data', payload_data
    post '/sources/jumpstartlab/data', payload_data_two
    visit '/sources/jumpstartlab'

    assert page.has_content?(" ") #url
    assert page.has_content?("Web Browser Breakdown") #user_agent
    assert page.has_content?("OS Breakdown") #user_agent
    assert page.has_content?("Screen Resolution") # resolution_width, resolution_height
    assert page.has_content?("Longest to Shortest Response Times") # responded_in
    assert page.has_content?("URL specific data")
    assert page.has_content?("View event specific data")
  end

  def test_events
    populate_sources
    visit '/sources/jumpstartlab/events'
    post '/sources/jumpstartlab/data', payload_data

    assert page.has_content?("Hyperlinks of each URL")
  end


end
