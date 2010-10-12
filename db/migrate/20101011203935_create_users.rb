class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
			# rpx
      t.string :identifier
			t.string :name
			t.string :username
			t.string :email

			# twitter
      t.string :twitter_screen_name
      t.string :twitter_token
      t.string :twitter_secret

      t.timestamps
    end

		add_index :users, :identifier
  end

  def self.down
    drop_table :users
  end
end
