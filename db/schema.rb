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

ActiveRecord::Schema.define(version: 20_201_012_115_446) do
  create_table 'admins', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_admins_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_admins_on_reset_password_token', unique: true
  end

  create_table 'bigs', force: :cascade do |t|
    t.string 'name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'contacts', force: :cascade do |t|
    t.integer 'user_id'
    t.text 'title', null: false
    t.text 'body', null: false
    t.text 'reply'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'favorites', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'muscle_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'muscle_comments', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'muscle_id'
    t.text 'comment', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'muscle_tags', force: :cascade do |t|
    t.integer 'muscle_id', null: false
    t.string 'tag_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'muscles', force: :cascade do |t|
    t.integer 'user_id'
    t.text 'memo', null: false
    t.string 'set_count', null: false
    t.string 'weight', null: false
    t.string 'rep', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'part_id'
    t.string 'work_tag'
    t.datetime 'start_time'
  end

  create_table 'parts', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.integer 'big_id'
  end

  create_table 'relationships', force: :cascade do |t|
    t.integer 'following_id'
    t.integer 'follower_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'tags', force: :cascade do |t|
    t.string 'tag_name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'name', null: false
    t.string 'image_id'
    t.boolean 'is_deleted', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
