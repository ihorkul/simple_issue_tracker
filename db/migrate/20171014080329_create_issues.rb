class CreateIssues < ActiveRecord::Migration[5.1]
  def change
    create_table :issues do |t|
      t.string :subject
      t.text :content
      t.integer :department_id
      t.references :user, foreign_key: true
      t.references :status, foreign_key: true
      t.string :user_name
      t.string :email
      t.string :key

      t.timestamps
    end
    add_index :issues, :key, unique: true

  end
end
