class CreateStages < ActiveRecord::Migration
  def change
    create_table :stages do |t|
      t.integer :user_id
      t.string :stage_type
      t.timestamps
    end
  end
end
