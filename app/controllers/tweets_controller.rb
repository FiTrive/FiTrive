class TweetsController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]

    before_action :ensure_correct_user, only: [:edit, :update, :destroy]
    
    def index
        
        if params[:tag_ids].present?
            @tweets = []
            params[:tag_ids].each do |key, value|
                if value == "1"
          # タグが存在しない場合のエラーを防止（&. と || []）
                    tag_tweets = Tag.find_by(name: key)&.tweets || []
                    @tweets = @tweets.empty? ? tag_tweets : @tweets & tag_tweets
                 end
            end
        else
      # 2. 検索していない時は全件取得
            @tweets = Tweet.all
        end
        @tweet = Tweet.new
    end


    

    def new
        @tweet =Tweet.new
    end

    def create
        tweet = Tweet.new(tweet_params)

        tweet.user_id = current_user.id

        if tweet.save!
            redirect_to :action => "index"
        else
            redirect_to :action => "new"
        end
    end

    def show
        @tweet = Tweet.find(params[:id])

        @comments = @tweet.comments
        @comment = Comment.new
    end

    def edit
        @tweet = Tweet.find(params[:id])
    end

    def update
        tweet = Tweet.find(params[:id])
        if tweet.update(tweet_params)
            redirect_to :action => "show", :id => tweet.id
        else
            redirect_to :action => "new"
        end
    end

    def destroy
        tweet = Tweet.find(params[:id])
        tweet.destroy
        redirect_to action: :index
    end

    private
    def tweet_params
        params.require(:tweet).permit(:spot_name, :address, :time, :who, :experience, :advice, :image, tag_ids: [])
    end

    def ensure_correct_user
        @tweet = Tweet.find(params[:id])
        if @tweet.user_id != current_user.id
            redirect_to tweets_path, alert: "他人の投稿は編集・削除できません。"
        end
    end

end
