class CreateCollaborators < ActiveRecord::Migration[5.0]
  def change
    create_table :collaborators do |t|
      t.string :email
      t.references :wiki
      t.references :user

      t.timestamps
    end
    add_foreign_key :collaborators, :wiki
    add_foreign_key :collaborators, :user
  end
end
