class CreateSleepRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :sleep_records, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid, index: true
      t.datetime :clock_in, null: false
      t.datetime :clock_out
      t.integer :duration

      t.timestamps
    end

    add_index :sleep_records, [:user_id, :clock_in]
    add_index :sleep_records, :duration
  end
end
