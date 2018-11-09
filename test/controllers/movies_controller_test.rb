require "test_helper"

describe MoviesController do
  MOVIE_FIELDS = %w(id title release_date).sort
  MOVIE_SHOW_FIELDS = %w(id title inventory overview release_date).sort

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status

    body = JSON.parse(response.body)

    expect(response.header['Content-Type']).must_include 'json'

    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "is a working route" do
      get movies_path, as: :json
      body = check_response(expected_type: Array)

      expect(body.count).must_equal Movie.count
      body.each do |movie|
        expect(movie.keys.sort).must_equal MOVIE_FIELDS.sort
      end
    end

    it "returns an empty array if no customers" do
      Movie.destroy_all

      get movies_path, as: :json
      must_respond_with :success

      body = JSON.parse(response.body)

      expect(body).must_equal []
    end
  end

  describe "show" do
    it "is a working route" do
      movie = movies(:priscilla)

      get movie_path(movie), as: :json

      body = check_response(expected_type: Hash)
      expect(body.keys.sort).must_equal MOVIE_SHOW_FIELDS
    end


    it "sends back not_found when the pet DNE" do
      movie = movies(:priscilla)

      movie.destroy

      get movie_path(movie)

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body).must_include "errors"
    end
  end

end
