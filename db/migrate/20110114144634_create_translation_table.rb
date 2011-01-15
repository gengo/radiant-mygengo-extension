class CreateTranslationTable < ActiveRecord::Migration
  def self.up
    create_table "mygengo_translations", :force => true do |t|
      t.integer  "job_id"
      t.text     "body_src"
      t.text     "body_tgt"
      t.string   "lc_src", :limit => 2
      t.string   "lc_tgt", :limit => 2
      t.string   "status"
    end
  end

  def self.down
    remove_table "mygengo_translations"
  end
end
