require './test/test_helper'

class ViewStatTest < ControllerTest
  def populate
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', payload_data
    post '/sources/jumpstartlab/data', payload_data_two
    post '/sources/jumpstartlab/data', payload_data_three
  end

  def test_it_can_find_URLs_by_id
    populate
    assert_equal 1, TrafficSpy::URL.find(id = 1).id
    assert_equal 2, TrafficSpy::URL.find(id = 2).id
    assert_equal "http://jumpstartlab.com/blog", TrafficSpy::URL.find(id = 1).url
    assert_equal "http://jumpstartlab.com/test", TrafficSpy::URL.find(id = 2).url
    assert_equal "http://jumpstartlab.com/blog", TrafficSpy::URL.find(TrafficSpy::Payload.first.url_id).url
  end

  def test_it_has_hour_by_hour_break_down
    post '/sources', { identifier:  "jumpstartlab",
                       rootUrl:     "http://jumpstartlab.com" }
    post '/sources/jumpstartlab/data', payload_data
    post '/sources/jumpstartlab/data', payload_data_four
    get "/sources/jumpstartlab/events/socialLogin"
  end

end
