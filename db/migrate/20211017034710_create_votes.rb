class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :value, null: false
      t.references :user, foreign_key: true
      t.belongs_to :votable, polymorphic: true

      t.timestamps
    end

    add_column :questions, :raiting, :integer, default: 0
    add_column :answers, :raiting, :integer, default: 0
  end
end
