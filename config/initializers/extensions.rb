Dir.glob(Rails.root.join('lib/extensions/**/*.rb')).sort.each do |filename|
  require filename
end