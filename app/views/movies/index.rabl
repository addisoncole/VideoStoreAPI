collection @movies
attributes :id, :title, :release_date
node :available_inventory do |m|
  m.get_available_number
end
