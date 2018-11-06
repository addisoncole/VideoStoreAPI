require "test_helper"

describe CustomersController do
  CUSTOMER_FIELDS = %w(id name registered_at address city state postal_code phone).sort

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status

    body = JSON.parse(response.body)

    expect(response.header['Content-Type']).must_include 'json'

    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "is a working route" do
      get customers_path
      body = check_response(expected_type: Array)

      expect(body.length).must_equal Customer.count
      body.each do |customer|
        expect(customer.keys.sort).must_equal CUSTOMER_FIELDS.sort
      end
    end

    it "returns an empty array if no customers" do
      Customer.destroy_all

      get customers_path
      must_respond_with :success

      body = JSON.parse(response.body)

      expect(body).must_equal []
    end
  end

end
