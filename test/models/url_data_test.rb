require './test/test_helper'
require 'json'

  class UrlDataTest < ControllerTest
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

    def test_it_can_find_min_and_max
      populate

      assert_equal [{"http://jumpstartlab.com/blog"=>2}, {"http://jumpstartlab.com/test"=>1}], UrlData.find_min_max(TrafficSpy::Payload, TrafficSpy::URL)
    end

    def test_it_has_an_os_breakdown
      populate

      assert_equal "OS X 10.8.2", UrlData.breakdown_os(TrafficSpy::Payload, TrafficSpy::Agent).join( " , " )
    end

    def test_it_finds_browser_data
      populate

      assert_equal "Chrome", UrlData.find_browser_data(TrafficSpy::Payload, TrafficSpy::Agent).join( " , " )
    end

    def test_it_can_find_resolution_data
      populate

      assert_equal "1920 x 1280", UrlData.find_resolution(TrafficSpy::Payload).join( " , " )
    end

    def test_it_can_find_response_time
      populate

      assert_equal "666 , 666 , 666 , 37 , 37",  UrlData.find_response(TrafficSpy::Payload).join(" , ")
    end

  end
