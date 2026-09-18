class SpotsController < ApplicationController
  def index
  end

  def new
    @spot = Spot.new
  end

  def show
    @spot = Spot.find_by(id: params[:id])

    # 1. 診断結果から当てはまるすべてのタグ名を配列で取得（例: ["一時間", "緑", "カップル"]）
    @result_tag_names = determine_tags(@spot)

    # 2. 取得したタグすべてを満たす（AND検索）投稿だけを抽出
    if @result_tag_names.present?
      @related_tweets = nil
      @result_tag_names.each do |tag_name|
        tag = Tag.find_by(name: tag_name)
        tag_tweets = tag ? tag.tweets.to_a : []
        # 最初のタグの投稿から始まり、2つ目以降のタグと論理積（&）をとって絞り込む
        @related_tweets = @related_tweets.nil? ? tag_tweets : (@related_tweets & tag_tweets)
      end
    else
      @related_tweets = []
    end
  end

  def create
    if params[:spot].blank?
      flash[:alert] = "選択肢を選んでから診断してください"
      redirect_to action: "new" and return
    end
    
    spot = Spot.new(spot_params)
    if spot.save
      flash[:notice] = "診断が完了しました"
      redirect_to spot_path(spot.id)
    else
      redirect_to action: "new"
    end
  end

  private

  def spot_params
    params.require(:spot).permit(:question1, :question2, :question3, :question4)
  end

  # 各質問の回答に応じて、当てはまるタグをすべて配列に入れて返す
  def determine_tags(spot)
    return [] unless spot

    tags = []

    # question1 (時間)
    case spot.question1
    when "1"
      tags << "一時間"
    when "2"
      tags << "三時間"
    when "3"
      tags << "五時間"
    end

    # question2 (テーマ)
    case spot.question2
    when "1"
      tags << "緑"
    when "2"
      tags << "青"
    when "3"
      tags << "食"
    end

    # question3 (誰と)
    case spot.question3
    when "1"
      tags << "家族"
    when "2"
      tags << "友達"
    when "3"
      tags << "カップル"
    when "4"
      tags << "1人"
    end

    tags.compact
  end
end