class CreatePasswordResets < ActiveRecord::Migration[5.0]
  def change
    create_table :password_resets do |t|
      t.string :token
      t.datetime :expires_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
