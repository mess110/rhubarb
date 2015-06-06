RhubarbItem.delete({})

Rhubarb.all.each do |h|
  RhubarbItem.create h
end

puts "RhubarbItem count: #{RhubarbItem.count}"
