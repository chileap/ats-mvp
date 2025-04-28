class CreateCandidates < ActiveRecord::Migration[7.1]
  def change
    create_table :candidates, id: :uuid do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
