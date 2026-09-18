# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Tag.create([
  { name: '緑' },
  { name: '青' },
  { name: '食' },
  { name: '一時間' },
  { name: '三時間' },
  { name: '五時間' },
  { name: '友達' },
  { name: '家族' },
  { name: 'カップル' },
  { name: '1人' },
])