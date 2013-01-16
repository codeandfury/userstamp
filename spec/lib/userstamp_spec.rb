require File.dirname(__FILE__) + '/../spec_helper'

class User < ActiveRecord::Base
  model_stamper
end

class Post < ActiveRecord::Base
  stampable :stamper_class_name => :user
end

class Ping < ActiveRecord::Base
  stampable :stamper_class_name => :person,
            :creator_attribute  => :creator_name,
            :updater_attribute  => :updater_name,
            :deleter_attribute  => :deleter_name
end

describe "Userstamp" do
  before(:all) do
    @zeus = User.create(id: 1, name: "Zeus")
    @hera = User.create(id: 2, name: "Hera")
  end
  
  describe "stampable" do
    context "default configuration" do
      before(:all) do
        class Comment < ActiveRecord::Base
          stampable :stamper_class_name => :user
        end
        
        User.stamper = @zeus
      end
      
      it "marks the creator_id and the updated_by" do
        comment = Comment.create(text: "basic comment")
        expect(comment.creator_id).to eq @zeus.id
        expect(comment.creator).to eq @zeus
        expect(comment.updated_by).to eq @zeus.id
        expect(comment.updater).to eq @zeus
      end
    end
    
    context "compatibility mode is enabled" do

      let(:person) { Person.create(name: "Josh") }

      before(:all) do
        # Class must be re-defined after compatibility_mode is changed
        Ddb::Userstamp.compatibility_mode = true
        class Person < ActiveRecord::Base
          stampable
        end
        
        User.stamper = @zeus
      end
      
      it "marks the created_by field" do 
        expect(person.created_by).to eq @zeus.id
        expect(person.creator).to eq @zeus
      end
      
      it "marks the updated_by field" do
        person.name = "Dave"
        person.save
        expect(person.name).to eq "Dave"
        expect(person.updated_by).to eq @zeus.id
        expect(person.updater).to eq @zeus
      end
      
      it "marks the deleted_by field" do
        expect(person.name).to eq "Josh"
        person.destroy
        expect(person.deleted_by).to eq @zeus.id
        expect(person.deleter).to eq @zeus
      end
    end
    
    context "compatibility mode is disabled" do

      let(:post) { Post.create(title: "Sample One") }

      before(:all) do
        # This is the default value for the compatibility mode
        # Ddb::Userstamp.compatibility_mode = false
        User.stamper = @zeus
      end

      it "marks the created_by field" do 
        expect(post.creator_id).to eq @zeus.id
        expect(post.creator).to eq @zeus
      end
      
      it "marks the updated_by field" do
        post.title = "Sample Two"
        post.save
        expect(post.title).to eq "Sample Two"
        expect(post.updater_id).to eq @zeus.id
        expect(post.updater).to eq @zeus
      end
      
      it "marks the deleted_by field" do
        expect(post.title).to eq "Sample One"
        post.destroy
        expect(post.deleter_id).to eq @zeus.id
        expect(post.deleter).to eq @zeus
      end
    end
    
    context "custom stampable fields" do
      before(:each) do
        
      end
    end  
  end
  
  describe "stamper" do
    it "can be selected by object" do
      User.stamper = @zeus
      expect(@zeus.id).to eq User.stamper
    end
    
    it "can be selected by integer" do
      User.stamper = @hera.id
      expect(@hera.id).to eq User.stamper
    end
  end
  
  describe "controllers" do
    
  end
end
