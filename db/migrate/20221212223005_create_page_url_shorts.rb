class CreatePageUrlShorts < ActiveRecord::Migration[6.1]
  def change
    create_table :page_url_shorts do |t|
      t.string :origin_url
      t.string :redirect_url
      t.integer :view_counter, default: 0
      t.string :title

      t.timestamps
    end
  end
end
