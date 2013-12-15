class CreateItems < ActiveRecord::Migration
  def up
  	create_table :items do |t|
      t.string :guid
      t.string :link
      t.string :pubDate
      t.string :title
      t.string :description
  		t.timestamps
  	end
  end

  def down
  	drop_table :items
  end
end
