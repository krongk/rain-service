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

ActiveRecord::Schema.define(version: 20130901105806) do

  create_table "keystores", force: true do |t|
    t.string  "key",   null: false
    t.integer "value", null: false
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

  create_table "phone_items", force: true do |t|
    t.integer  "user_id"
    t.string   "mobile_phone", null: false
    t.string   "source_name"
    t.string   "name"
    t.string   "city"
    t.string   "area"
    t.string   "description"
    t.string   "is_processed"
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
    t.string   "mobile_phone",                 null: false
    t.string   "email",                        null: false
    t.text     "content",                      null: false
    t.boolean  "is_processed", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_comments", ["site_id"], name: "index_site_comments_on_site_id", using: :btree

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
    t.string   "site_name",                    null: false
    t.string   "site_title",                   null: false
    t.string   "domain"
    t.integer  "theme_id",                     null: false
    t.text     "head"
    t.text     "header"
    t.text     "body"
    t.text     "footer"
    t.boolean  "is_published", default: false
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
    t.string "name", null: false
  end

  create_table "user_details", force: true do |t|
    t.integer  "user_id",             null: false
    t.string   "contact_name",        null: false
    t.string   "id_card"
    t.string   "mobile_phone",        null: false
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
    t.string   "company_keywords"
    t.text     "company_description"
    t.string   "fu_gmail_name"
    t.string   "fu_gmail_pwd"
    t.string   "fu_qmail_name"
    t.string   "fu_qmail_pwd"
    t.string   "fu_user_name"
    t.string   "fu_user_pwd"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_details", ["user_id"], name: "index_user_details_on_user_id", using: :btree

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
