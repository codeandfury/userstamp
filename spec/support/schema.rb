ActiveRecord::Schema.define(:version => 0) do
  create_table :users, :force => true do |t|
    t.column :name,           :string
    t.column :creator_id,     :integer
    t.column :created_on,     :datetime
    t.column :updater_id,     :integer
    t.column :updated_at,     :datetime
    t.column :deleter_id,     :integer
    t.column :deleted_at,     :datetime
  end

  create_table :people, :force => true do |t|
    t.column :name,           :string
    t.column :created_by,     :integer
    t.column :created_on,     :datetime
    t.column :updated_by,     :integer
    t.column :updated_at,     :datetime
    t.column :deleted_by,     :integer
    t.column :deleted_at,     :datetime
  end

  create_table :posts, :force => true do |t|
    t.column :title,          :string
    t.column :creator_id,     :integer
    t.column :created_on,     :datetime
    t.column :updater_id,     :integer
    t.column :updated_at,     :datetime
    t.column :deleter_id,     :integer
    t.column :deleted_at,     :datetime
  end
  
  create_table :comments, :force => true do |t|
    t.column :text,           :string
    t.column :creator_id,     :integer
    t.column :created_on,     :datetime
    t.column :updated_by,     :integer
    t.column :updated_at,     :datetime
  end

  create_table :pings, :force => true do |t|
    t.column :ping,           :string
    t.column :creator_user,   :string
    t.column :created_at,     :datetime
    t.column :updater_user,   :string
    t.column :updated_at,     :datetime
    t.column :deleter_user,   :string
    t.column :deleted_at,     :datetime
  end
  
  create_table :faces, :force => true do |t|
    t.column :test_name,       :string
    t.userstamps(true)
  end
end