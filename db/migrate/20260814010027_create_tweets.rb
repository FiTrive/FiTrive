class CreateTweets < ActiveRecord::Migration[7.2]
  def change
    create_table :tweets do |t|
      t.string :spot_name
      t.string :address
      t.string :time
      t.string :who
      t.text :experience
      t.text :advice

      t.timestamps
    end
  end
end
