class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:edit, :destroy]

  def index
    @blogs = Blog.all
    
  end

  def new
    @blog = Blog.new
  end

  def create
    # @blog = Blog.create(blog_params)
    # if @blog.save
    # redirect_to blogs_path, notice:"ブログを作成しました。"
    # else 
    # render :new 
    # end

    # back機能を兼ね揃えたcreateの書き方。back時parameterが失われない。
    # @blog = Blog.new(blog_params)
    # @blog.user_id = current_user.id
    # 上記2行は下記1行で完結できる。current_user.blogs.buildは「ログイン中のユーザーの、blogを、build(new)する」
    @blog = current_user.blogs.build(blog_params)
    # binding.irb
    if params[:back]
      render :new
    else
      if @blog.save
        # binding.irb
        NoticeMailer.notice_mailer(@blog).deliver
        # binding.irb
        redirect_to blogs_path, notice: "ブログを作成しました！"
      else
        render :new
      end
    end
  end

  def show
    
  end

  def edit
    if current_user.id != @blog.user_id
      # binding.irb
      redirect_to blogs_path, notice:"他人のブログ編集は出来ません!"
    end
    
  end

  def update
    if @blog.update(blog_params)
      # binding.irb
      redirect_to blogs_path, notice:"ブログを編集しました。"
    else
      render :edit
    end
  end

  def destroy
    if current_user.id != @blog.user_id
      # binding.irb
      redirect_to blogs_path, notice:"他人のブログ削除は出来ません!"
    else
      @blog.destroy
      redirect_to blogs_path, notice:"ブログを削除しました！"
    end
  end

  def confirm
    # @blog = Blog.new(blog_params)
    # @blog.user_id = current_user.id
    @user = User.find(session[:user_id])
    @blog = current_user.blogs.build(blog_params)
    if @blog.invalid?
      render :new
    end
  end


  private
  def blog_params
    params.require(:blog).permit(:title, :content, :image, :image_cache)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def logged_in?
    unless current_user.present?
      redirect_to new_user_path, notice: "ログインするか新規ユーザー設定後Blogをご使用下さい。"
    end
  end
end




