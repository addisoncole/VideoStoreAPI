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

end
