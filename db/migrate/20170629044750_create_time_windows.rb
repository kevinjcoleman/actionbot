class CreateTimeWindows < ActiveRecord::Migration[5.1]
  def change
    create_table :time_windows do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.references :timeable, polymorphic: true

      t.timestamps
    end
  end
end
