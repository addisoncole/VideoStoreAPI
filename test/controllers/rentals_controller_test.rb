require "test_helper"

describe RentalsController do

  let(:customer_id) {customers(:sontag)}
  let(:movie_id) {movies(:one)}
  let(:rental_data) {
    {
      "movie": movie_id
      "customer": customer_id
    }
  }

  describe "checkout" do
    it "creates new rental with valid request data" do
      expect {
        post checkout_path(rental_data)
      }.must_change("Rental.count", +1)

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      rental = Rental.find(body["id"].to_i)
      # binding.pry
      expect(rental.movie_id).must_equal rental_data["movie_id"]
      expect(rental.customer_id).must_equal rental_data["customer_id"]
      must_respond_with :success
    end
    it "returns error message when movie out of stock" do
    end
  end
end
