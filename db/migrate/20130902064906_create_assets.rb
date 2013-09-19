#encoding: utf-8
class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.references :user, index: true
      t.string :asset_type, default: '默认'

    end
  end
end
