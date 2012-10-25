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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121022185613) do

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.string   "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "areas_chains", :id => false, :force => true do |t|
    t.integer  "area_id"
    t.integer  "chain_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["slug"], :name => "index_articles_on_slug", :unique => true

  create_table "chains", :force => true do |t|
    t.string   "name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.string   "logo_file_name"
    t.datetime "logo_updated_at"
    t.text     "info"
    t.string   "site"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chains_cities", :id => false, :force => true do |t|
    t.integer  "city_id"
    t.integer  "chain_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.boolean  "okrug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "discussions", :force => true do |t|
    t.string   "title"
    t.string   "ancestry"
    t.boolean  "visible",    :default => false
    t.text     "body"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.string   "user_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "discussions", ["ancestry"], :name => "index_discussions_on_ancestry"
  add_index "discussions", ["parent_id"], :name => "index_discussions_on_parent_id"

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unit",       :default => ""
  end

  create_table "promotions", :force => true do |t|
    t.string   "banner_content_type"
    t.integer  "banner_file_size"
    t.string   "banner_file_name"
    t.datetime "banner_updated_at"
    t.string   "name"
    t.string   "link"
    t.string   "info"
    t.string   "key"
    t.integer  "user_id"
    t.integer  "count",               :default => 0
    t.integer  "balance",             :default => 0
    t.boolean  "active",              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "shop_products", :force => true do |t|
    t.integer  "shop_id"
    t.integer  "product_id"
    t.decimal  "price"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "volume",     :default => 0
  end

  create_table "shops", :force => true do |t|
    t.integer  "chain_id"
    t.string   "name"
    t.integer  "area_id"
    t.integer  "raiting",    :default => 1
    t.string   "adds"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "real_price", :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "salt"
    t.integer  "shop_id"
    t.integer  "city_id"
    t.boolean  "admin",                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
  end

  add_index "users", ["activation_token"], :name => "index_users_on_activation_token"
  add_index "users", ["remember_me_token"], :name => "index_users_on_remember_me_token"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token"

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "xml_files", :force => true do |t|
    t.integer  "shop_id"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.string   "attach_file_name"
    t.datetime "attach_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
