#encoding: utf-8
class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :user, index: true
      t.string :asset_cate, default: '默认'
      t.string :bucket
      t.string :asset_key
      t.string :note

      t.timestamps
    end
  end
end
