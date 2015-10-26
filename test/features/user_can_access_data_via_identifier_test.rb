require './test/test_helper'

class IdentifierViewTest < FeatureTest
  include Capybara::DSL

  def test_user_can_view_their_own_identifier_page
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', payload_data
    post '/sources/jumpstartlab/data', payload_data_two
    visit '/sources/jumpstartlab/url/blog'

    assert page.has_content?("URL Stats!")
    assert page.has_content?("© 2015 Keep Slota Wild Inc.")

    assert page.has_content?("Longest response time")
    assert page.has_content?("37.0")

    assert page.has_content?("Shortest response time")

    assert page.has_content?("Average response time")
    assert page.has_content?("37.0")

    assert page.has_content?("Which HTTP verbs have been used") # responded_in
    assert page.has_content?("GET")

    assert page.has_content?("Most popular referrrers:")
    assert page.has_content?("http://jumpstartlab.com")

    assert page.has_content?("Most popular user agents:")
    assert page.has_content?("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko)")
  end
end
