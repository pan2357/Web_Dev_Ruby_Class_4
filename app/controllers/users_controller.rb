class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :set_post, only: %i[ edit_post edit_post_process delete_post]
  
  # = before_action(:set_user, only: [:show, :edit, :update, :destroy])
  # before performing action in function show, edit, update, destroy
  # call function set_user

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @posts = @user.posts
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_fast
    @name = params[:name]
    @email = params[:email]
    User.create(name:@name, email:@email)
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    # respond_to do |format|
    #   format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  def main
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user == nil
      redirect_to main_url, notice: "Email not existed"
    else
      pass = params[:pass]
      if @user.pass!=pass
        redirect_to main_url, notice: "Email or Password incorrect"
      else
        redirect_to @user
      end
    end
  end

  def create_post
    @post = Post.new
    @post.user_id = params[:user_id]
  end

  def create_post_process
    @post = Post.new(post_params)
    if @post.save
      redirect_to user_url(@post.user_id), notice: "Post created successfully"
    end
  end

  def edit_post
  end

  def edit_post_process
    if @post.update(post_params)
      redirect_to user_url(@post.user_id), notice: "Post updated successfully"
    end
  end

  def delete_post
    @post.destroy
    redirect_to user_url(params[:user_id]), notice: "Post deleted successfully"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_post
      @post = User.find(params[:user_id]).posts.find(params[:post_id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :birthday, :address, :postal_code, :pass)
    end

    def post_params
      params.require(:post).permit(:msg, :user_id)
    end
end
