require('pry-byebug')
require_relative('models/property')

house1 = Property.new({
    'address' => '12 Seasame Street', 
    'build' => 'Bungalow', 
    'value' => 100000, 
    'year_built' => '1900'
})

house2 = Property.new({
    'address' => '15 Constitution Street', 
    'build' => 'Semi-Detached', 
    'value' => 150000, 
    'year_built' => '1945'
})

house1.save()
house2.save()

binding.pry 

nil