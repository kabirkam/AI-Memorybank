class CreateSentences < ActiveRecord::Migration[7.0]
  def change
    create_table :sentences do |t|
      t.text :text
      t.boolean :like, default: true
      t.references :note, null: false, foreign_key: true

      t.timestamps
    end
  end
end
