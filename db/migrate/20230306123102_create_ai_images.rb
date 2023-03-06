class CreateAiImages < ActiveRecord::Migration[7.0]
  def change
    create_table :ai_images do |t|

      t.timestamps
    end
  end
end
