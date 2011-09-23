class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username , :null => false
      t.string :password, :null => false
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :gender, :null => false
      t.string :email, :null => false
      t.string :user_type, :null => false
      t.date :birth_date, :null => false

      t.timestamps
    end

    add_index :users, :username
    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end
