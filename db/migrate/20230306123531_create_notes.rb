class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.text :text
      t.binary :audio
      t.boolean :archived
      t.references :user, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true
      t.references :ai_image, null: false, foreign_key: true
      t.references :reminders, null: false, foreign_key: true
      t.timestamps
    end
  end
end


rails active_storage:install
rails db:migrate
