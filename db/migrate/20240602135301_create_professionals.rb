class CreateProfessionals < ActiveRecord::Migration[7.1]
  def change
    create_table :professionals do |t|
      t.string :name
      t.text :description
      t.string :contact_info

      t.timestamps
    end
  end
end
