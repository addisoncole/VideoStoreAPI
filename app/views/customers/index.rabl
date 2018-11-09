collection @customers
attributes :id, :name, :registered_at, :postal_code, :phone
node :movies_checked_out_count do |c|
  c.get_number_checked_out
end
