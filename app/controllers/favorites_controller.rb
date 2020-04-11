class FavoritesController < ApplicationController
  def show
    # 今ログインしているユーザーが、そのブログをお気に入り登録しているかどうか, 1329より
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def create
    favorite = current_user.favorites.create(blog_id: params[:blog_id])
    redirect_to blogs_url, notice: "#{favorite.blog.user.name}さんのブログをお気に入り登録しました"
  end
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to blogs_url, notice: "#{favorite.blog.user.name}さんのブログをお気に入り解除しました"
  end
end
