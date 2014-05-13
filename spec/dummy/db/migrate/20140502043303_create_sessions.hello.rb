# This migration comes from hello (originally 2)
class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, index: true
      t.references :credential, index: true
      t.string :ua
      t.datetime :expires_at
      t.datetime :sudo_expires_at

      t.timestamps
    end
  end
end
