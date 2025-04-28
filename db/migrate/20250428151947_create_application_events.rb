class CreateApplicationEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :application_events, id: :uuid do |t|
      t.references :application, null: false, foreign_key: true, type: :uuid
      t.string :type
      t.datetime :interview_date
      t.datetime :hired_at
      t.datetime :rejected_at
      t.text :content

      t.timestamps
    end
  end
end
