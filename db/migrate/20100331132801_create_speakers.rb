class CreateSpeakers < ActiveRecord::Migration
  def self.up
    create_table :speakers do |t|
      t.string :full_name
      t.string :email
      t.string :homepage
      t.text :biography
      t.boolean :headshot, :default => false

      t.userstamps
      t.timestamps
    end
  end

  def self.down
    drop_table :speakers
  end
end
