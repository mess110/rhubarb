RhubarbItem.delete({})

Rhubarb.all.each do |h|
  RhubarbItem.create h
end

puts "There are #{RhubarbItem.count} items"
puts "and #{RhubarbUser.count} users in teh db." # intentional typo
