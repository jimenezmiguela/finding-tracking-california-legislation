class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.references :user, null: false, foreign_key: true
      t.string :measure
      t.string :subject
      t.string :author
      t.string :status
      t.string :summary
      t.string :vote
      t.boolean :appropriation
      t.boolean :fiscal_committee
      t.boolean :local_program
      t.boolean :high_priority
      t.string :category

      t.timestamps
    end
  end
end
