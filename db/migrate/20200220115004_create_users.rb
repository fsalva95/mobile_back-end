class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :address
      t.string :mobile
      t.string :activation_digest
      t.boolean :activated, default: false

      t.timestamps
    end
  end
end
