class AddUserCredentialsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :login, :string
    add_column :users, :password, :string
    add_column :users, :password_confirmation, :string
    add_column :users, :crypted_password, :string
    add_column :users, :email, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :salt, :string
    add_column :users, :persistence_token, :string
  end
end
