class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string    :name,                                                          :null => false
      t.string    :seo_url,                                                       :null => false
      t.text      :description
      t.enum      :classification, :limit => [:tag, :category], :default => :tag, :null => false

      t.timestamps
    end
  end
end
