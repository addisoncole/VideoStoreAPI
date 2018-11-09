collection @movies
attributes :id, :title, :release_date

object @movie
child :available_inventory do |movie|
  @movie.get_available_number
end
