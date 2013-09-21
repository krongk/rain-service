class CreateUserThemes < ActiveRecord::Migration
  def change
    create_table :user_themes do |t|
      t.references :user, index: true
      t.references :theme, index: true
    end
  end
end
