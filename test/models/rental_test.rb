require "test_helper"

describe Rental do
  let(:rental) { rentals(:rentalone) }
  let(:rental_data) {
     { "movie_id": movies(:goonies).id,
       "customer_id": customers(:sontag).id }
     }

  describe "validations" do

    it 'is valid if all fields are present' do
      expect(rental).must_be :valid?
    end

    it 'is not valid if it does not have a movie' do
      expect(rental).must_be :valid?

      rental.movie = nil

      expect(rental).wont_be :valid?
    end

    it 'is not valid if it does not have a customer' do
      expect(rental).must_be :valid?

      rental.customer = nil

      expect(rental).wont_be :valid?
    end

  end

  describe "relations" do

    it "has a customer" do
      rental.must_respond_to :customer
      rental.customer.must_be_kind_of Customer
    end

    it "has a movie" do
      rental.must_respond_to :movie
      rental.movie.must_be_kind_of Movie
    end

  end

  describe "set_rental_dates" do
    it "sets rental dates for valid rental" do
      rental = Rental.create(rental_data)
      rental.set_rental_dates

      now = DateTime.now
      checkout_date = now.strftime('%Y-%m-%d')

      expect(rental.checkout_date.strftime('%Y-%m-%d')).must_equal checkout_date

      due = DateTime.now + 7
      due_date = due.strftime('%Y-%m-%d')

      expect(rental.due_date.strftime('%Y-%m-%d')).must_equal due_date
    end
  end

  describe "check_movie_availability?" do
    it "returns true if movie is available" do
      rental = Rental.new(rental_data)
      expect(rental.check_movie_availability?).must_equal true
    end
    it "returns false if movie is not available" do
      no_inventory_rental = Rental.create(
        {"movie_id": movies(:no_inventory).id,
        "customer_id": customers(:sontag).id}
      )

      expect(no_inventory_rental.check_movie_availability?).must_equal false
    end
  end

end
