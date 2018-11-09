require "test_helper"

describe CustomersController do
  # render_views
  CUSTOMER_FIELDS = %w(id name registered_at postal_code phone check_out_count).sort

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status

    body = JSON.parse(response.body)

    expect(response.header['Content-Type']).must_include 'json'

    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "is a working route" do
      get customers_path, as: :json
      body = check_response(expected_type: Array)
      # binding.pry
      expect(body.count).must_equal Customer.count
      body.each do |customer|
        expect(customer.keys.sort).must_equal CUSTOMER_FIELDS.sort
      end
    end

    it "returns an empty array if no customers" do
      Customer.destroy_all

      get customers_path, as: :json
      must_respond_with :success

      body = JSON.parse(response.body)

      expect(body).must_equal []
    end
  end

end
