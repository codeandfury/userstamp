require "spec_helper"

describe PostsController do
  
  let(:mypost) {Post.create(title: "Original")}
  
  before(:all) do
    @zeus = User.create(id: 1, name: "Zeus")
    @hera = User.create(id: 2, name: "Hera")
    User.stamper = @hera
  end
   
  before(:each) do
    session[:user_id] = @hera.id
  end
  
  describe "controller" do
    it "creates a post and sets the creator field" do
      post :create, {:post => { :title => "Created" }}
      mypost = Post.find(response.body)
      expect(mypost.creator_id).to eq @hera.id
      expect(mypost.creator).to eq @hera
    end
    
    it "updates a post and sets the updater field" do
      post_id = mypost.id
      put :update, {:id => post_id, :post => {:title => "Different"}}
      mypost = Post.find(post_id) # lookup the database post corresponding to the lazy loaded post object
      expect(mypost.title).to eq "Different"
      expect(mypost.updater_id).to eq @hera.id
      expect(mypost.updater).to eq @hera
    end
    
    it "deletes a post and sets the deleter field" do
      post_id = mypost.id
      delete :destroy, {:id => post_id}
      mypost = assigns(:mypost) # Assigns is a test helper method that can be used to access all the instance variables set in the last requested action
      expect(mypost.deleter_id).to eq @hera.id
      expect(mypost.deleter).to eq @hera
    end
  end
  
end