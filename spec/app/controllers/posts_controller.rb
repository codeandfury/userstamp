class PostsController < ActionController::Base
  include Userstamp
  
  def index
    render(:inline => "Look an index page")
  end
  
  def create
    @post = Post.create(params[:post])
    render(:inline => "<%= @post.id %>")
  end
  
  def edit
    @post = Post.find(params[:id])
    render(:inline  => "<%= @post.title %>")
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    @post.save
    render(:inline => "<%= @post.title %>")
  end
  
  def destroy
    @mypost = Post.find(params[:id])
    @mypost.destroy
    render(:inline => "BERGER")
  end

  protected
    def current_user
      User.find(session[:user_id])
    end
    
    def set_stamper
      User.stamper = self.current_user
    end

    def reset_stamper
      User.reset_stamper
    end    
  #end
end