class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.datetime :birth_date
      t.string :hashed_password

      t.timestamps
    end
    add_index :users, :username, unique: true

    create_table :friendships do |t|
      t.references :user
      t.references :friend, references: :user
    end

    add_index :friendships, [:user_id, :friend_id]
  end
end
