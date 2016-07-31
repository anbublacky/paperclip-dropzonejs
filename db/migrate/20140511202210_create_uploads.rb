class CreateUploads < ActiveRecord::Migration
  def change
    create_table :uploads do |t|
      t.references :music
      t.timestamps
    end
  end
end
