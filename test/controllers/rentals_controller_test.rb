require "test_helper"

describe RentalsController do
  # def check_response(expected_type:, expected_status: :success)
  #   must_respond_with expected_status
  #
  #   body = JSON.parse(response.body)
  #
  #   expect(response.header['Content-Type']).must_include 'json'
  #
  #   expect(body).must_be_kind_of expected_type
  #   return body
  # end
  #
  # describe "checkout" do
  #   it "is a working route" do
  #     post checkout_path, as: :json
  #     body = check_response(expected_type: Array)
  #
  #     expect(body.count).must_equal Rental.count
  #     body.each do |rental|
  #       expect(rental).must_be_kind_of Rental
  #     end
  #   end
  #
  #   it "returns an empty array if no customers" do
  #     Movie.destroy_all
  #
  #     get movies_path, as: :json
  #     must_respond_with :success
  #
  #     body = JSON.parse(response.body)
  #
  #     expect(body).must_equal []
  #   end
  # end
end
