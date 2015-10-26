require './test/test_helper'
require 'json'

module TrafficSpy
  class UrlDataTest < ControllerTest

    def test_it_creates_a_payload
      populate_sources
      data = JsonParser.parse_json(paycheck, Source.first)

      data.save

      assert_equal 1, Payload.first.id
      assert_equal "2013-02-16 21:38:28 -0700", Payload.first.requested_at
    end

    def paycheck
       {"url":"http://jumpstartlab.com/blog",
        "requestedAt":"2013-02-16 21:38:28 -0700",
        "respondedIn":37,
        "referredBy":"http://jumpstartlab.com",
        "requestType":"GET",
        "parameters":[],
        "eventName":"socialLogin",
        "userAgent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17",
        "resolutionWidth":"1920",
        "resolutionHeight":"1280",
        "ip":"63.29.38.211" }.to_json
    end

  end
end
