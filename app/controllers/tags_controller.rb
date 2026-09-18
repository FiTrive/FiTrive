class TagsController < ApplicationController
  before_action :authenticate_user! # ログインユーザーのみタグ追加を許可する場合

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_back fallback_location: tweets_path, notice: "新しいタグ「#{@tag.name}」を追加しました。"
    else
      redirect_back fallback_location: tweets_path, alert: "タグの追加に失敗しました。"
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end
end