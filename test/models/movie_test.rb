require "test_helper"

describe Movie do
  let(:movie) { movies(:one) }
  let(:no_title) {movie.title = nil}
  let(:no_inventory) {movie.inventory = nil}

  describe "validations" do
    it "is invalid without title" do
      no_title
      expect(movie).wont_be :valid?
    end

    it "is invalid without inventory" do
      no_inventory
      expect(movie).wont_be :valid?
    end

    it "requires title and inventory to be valid" do
      expect(movie).must_be :valid?
      expect(Movie.new).wont_be :valid?
    end
  end


end
