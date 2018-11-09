object @movie
attributes :id, :title, :release_date, :overview, :inventory
node :available_inventory do |m|
  m.get_available_number
end
