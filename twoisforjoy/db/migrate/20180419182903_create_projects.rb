class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :teaser_text
      t.column :description, :binary, :limit => 16.megabyte

      t.timestamps
    end
  end
end
