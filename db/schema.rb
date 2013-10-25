# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131025064146) do

  create_table "assets", force: true do |t|
    t.integer  "user_id"
    t.string   "asset_type",         default: "默认"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
  end

  add_index "assets", ["user_id"], name: "index_assets_on_user_id", using: :btree

  create_table "faq_cates", force: true do |t|
    t.integer "typo",                    null: false
    t.string  "name",                    null: false
    t.boolean "is_auth", default: false
  end

  create_table "faq_items", force: true do |t|
    t.integer "faq_cate_id",        null: false
    t.string  "title",              null: false
    t.text    "content"
    t.text    "markeddown_content"
  end

  add_index "faq_items", ["faq_cate_id", "title"], name: "index_faq_items_on_faq_cate_id", unique: true, using: :btree

  create_table "keystores", force: true do |t|
    t.string  "key",                         null: false
    t.integer "value", limit: 8, default: 0, null: false
  end

  create_table "mail_items", force: true do |t|
    t.integer  "user_id"
    t.string   "email",                      null: false
    t.string   "source_name"
    t.string   "name"
    t.string   "city"
    t.string   "area"
    t.string   "description"
    t.string   "is_processed", default: "n"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mail_items", ["user_id"], name: "index_mail_items_on_user_id", using: :btree

  create_table "mail_logs", force: true do |t|
    t.integer  "user_id",                   null: false
    t.integer  "mail_item_id",              null: false
    t.integer  "mail_tmp_id",               null: false
    t.integer  "status",        default: 0
    t.integer  "billing_count", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mail_logs", ["mail_item_id"], name: "index_mail_logs_on_mail_item_id", using: :btree
  add_index "mail_logs", ["mail_tmp_id"], name: "index_mail_logs_on_mail_tmp_id", using: :btree
  add_index "mail_logs", ["user_id"], name: "index_mail_logs_on_user_id", using: :btree

  create_table "mail_tmps", force: true do |t|
    t.integer  "user_id"
    t.string   "title",      null: false
    t.text     "content",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "mail_tmps", ["user_id"], name: "index_mail_tmps_on_user_id", using: :btree

  create_table "phone_calls", force: true do |t|
    t.integer  "user_id"
    t.string   "domain"
    t.string   "from_ip"
    t.string   "from_url"
    t.string   "from_phone"
    t.boolean  "is_processed"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phone_calls", ["user_id"], name: "index_phone_calls_on_user_id", using: :btree

  create_table "phone_items", force: true do |t|
    t.integer  "user_id"
    t.string   "mobile_phone",               null: false
    t.string   "source_name"
    t.string   "name"
    t.string   "city"
    t.string   "area"
    t.string   "description"
    t.string   "is_processed", default: "n", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "phone_items", ["user_id"], name: "index_phone_items_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "site_comments", force: true do |t|
    t.integer  "site_id",                      null: false
    t.string   "name"
    t.string   "mobile_phone"
    t.string   "email"
    t.text     "content",                      null: false
    t.boolean  "is_processed", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_comments", ["site_id"], name: "index_site_comments_on_site_id", using: :btree

  create_table "site_pages", force: true do |t|
    t.integer  "user_id",    null: false
    t.string   "short_id",   null: false
    t.integer  "site_id",    null: false
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_pages", ["site_id"], name: "index_site_pages_on_site_id", using: :btree
  add_index "site_pages", ["user_id"], name: "index_site_pages_on_user_id", using: :btree

  create_table "site_posts", force: true do |t|
    t.integer  "user_id",                  null: false
    t.integer  "site_id",                  null: false
    t.string   "title",                    null: false
    t.text     "content",                  null: false
    t.string   "key_words"
    t.integer  "cate_id",      default: 0
    t.integer  "is_processed", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_posts", ["site_id"], name: "index_site_posts_on_site_id", using: :btree
  add_index "site_posts", ["user_id"], name: "index_site_posts_on_user_id", using: :btree

  create_table "sites", force: true do |t|
    t.integer  "user_id"
    t.string   "short_id"
    t.string   "title"
    t.string   "domain"
    t.integer  "theme_id"
    t.text     "head"
    t.text     "header"
    t.text     "body"
    t.text     "footer"
    t.boolean  "is_published",             default: false
    t.string   "contact_name"
    t.string   "mobile_phone", limit: 16
    t.string   "tel_phone",    limit: 16
    t.string   "qq",           limit: 32
    t.string   "email",        limit: 64
    t.string   "website",      limit: 64
    t.string   "address",      limit: 128
    t.string   "company_name", limit: 128
    t.string   "duoshuo",      limit: 128
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sites", ["user_id"], name: "index_sites_on_user_id", using: :btree

  create_table "sms_logs", force: true do |t|
    t.integer  "user_id"
    t.integer  "phone_item_id"
    t.integer  "sms_tmp_id"
    t.integer  "status",        default: 0
    t.integer  "billing_count",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sms_logs", ["phone_item_id"], name: "index_sms_logs_on_phone_item_id", using: :btree
  add_index "sms_logs", ["sms_tmp_id"], name: "index_sms_logs_on_sms_tmp_id", using: :btree
  add_index "sms_logs", ["user_id"], name: "index_sms_logs_on_user_id", using: :btree

  create_table "sms_tmps", force: true do |t|
    t.integer  "user_id"
    t.string   "title",        null: false
    t.text     "content",      null: false
    t.integer  "content_size", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sms_tmps", ["user_id"], name: "index_sms_tmps_on_user_id", using: :btree

  create_table "themes", force: true do |t|
    t.string   "name",                                                              null: false
    t.string   "cate",                              default: "bootswatch",          null: false
    t.string   "tags"
    t.string   "templete_image"
    t.string   "templete_url"
    t.string   "default_pages",                     default: "关于我们|服务项目|成功案例|联系我们"
    t.text     "css_url"
    t.text     "js_url"
    t.text     "header"
    t.text     "body",           limit: 2147483647
    t.text     "footer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_accounts", force: true do |t|
    t.integer "user_id"
    t.string  "name"
    t.string  "value"
  end

  add_index "user_accounts", ["user_id", "name"], name: "index_user_accounts_on_user_id_and_name", unique: true, using: :btree
  add_index "user_accounts", ["user_id"], name: "index_user_accounts_on_user_id", using: :btree

  create_table "user_details", force: true do |t|
    t.integer  "user_id",                         null: false
    t.string   "contact_name"
    t.string   "id_card"
    t.string   "mobile_phone"
    t.string   "tel_phone"
    t.string   "qq"
    t.string   "email"
    t.string   "website"
    t.string   "region"
    t.string   "city"
    t.string   "district"
    t.string   "address"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "company_name"
    t.string   "company_nickname"
    t.string   "corporator"
    t.string   "company_reg_no"
    t.string   "company_reg_code",    limit: 128
    t.string   "company_keywords"
    t.text     "company_description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_details", ["user_id"], name: "index_user_details_on_user_id", using: :btree

  create_table "user_themes", force: true do |t|
    t.integer "user_id"
    t.integer "theme_id"
  end

  add_index "user_themes", ["theme_id"], name: "index_user_themes_on_theme_id", using: :btree
  add_index "user_themes", ["user_id"], name: "index_user_themes_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
