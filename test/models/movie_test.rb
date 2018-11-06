require "test_helper"

describe Movie do
  let(:movie) { movies(:one) }

  describe "validations" do
    it "requires title and inventory to be valid" do
      expect(movie).must_be :valid?

      invalid_movie = Movie.new

      expect(invalid_movie).wont_be :valid?
      expect(invalid_movie.errors.messages).must_include :inventory, :title
    end

    it "is invalid without title" do
      movie.title = nil

      expect(movie).wont_be :valid?
      expect(movie.errors.messages).must_include :title
    end

    it "is invalid without inventory" do
      movie.inventory = nil

      expect(movie).wont_be :valid?
      expect(movie.errors.messages).must_include :inventory
    end
  end

  describe "relations" do
    it "has a list of rentals" do
      movie.must_respond_to :rentals
      movie.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end

    it "returns empty array if no rentals" do
      rental = rentals(:one)

      expect(movie.rentals).must_equal []
    end
  end

end
