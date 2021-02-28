class AddUserNameAndPasswordToAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :user_name, :string
    add_column :authors, :password_digest, :string
  end
end
