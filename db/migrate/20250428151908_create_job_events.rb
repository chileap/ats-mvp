class CreateJobEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :job_events, id: :uuid do |t|
      t.references :job, null: false, foreign_key: true, type: :uuid
      t.string :type

      t.timestamps
    end
  end
end
