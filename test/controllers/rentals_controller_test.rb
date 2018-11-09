require "test_helper"

describe RentalsController do

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status

    body = JSON.parse(response.body)

    expect(response.header['Content-Type']).must_include 'json'

    expect(body).must_be_kind_of expected_type
    return body
  end

  # describe "checkout" do
  #   it "creates a new rental with valid request data" do
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

  # let(:customer_id) {customers(:sontag)}
  # let(:movie_id) {movies(:goonies)}
  # let(:rental_data) {
  #   {
  #     "movie": movies(:goonies)
  #     "customer": movies(:goonies)
  #   }
  # }

  describe "checkout" do
    it "creates new rental with valid request data" do
      # expect {
      #   post checkout_path(rental_data), as: :json
      # }.must_change("Rental.count", +1)

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      rental = Rental.find(body["id"].to_i)
      # binding.pry
      # expect(rental.movie.title).must_equal rental_data["movie_id"]
      # expect(rental.customer_id).must_equal rental_data["customer_id"]
      must_respond_with :success
    end
    it "returns error message when movie out of stock" do
    end
  end
end
