class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs, id: :uuid do |t|
      t.string :title
      t.text :description
      t.timestamps
    end
  end
end
