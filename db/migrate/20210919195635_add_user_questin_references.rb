class AddUserQuestinReferences < ActiveRecord::Migration[6.1]
  def change
    add_reference :answers, :user
  end
end
