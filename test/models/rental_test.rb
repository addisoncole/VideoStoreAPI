require "test_helper"

describe Rental do
  let(:rental) { rentals(:rentalone) }

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

end
