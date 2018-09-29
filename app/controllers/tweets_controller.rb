class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :update, :destroy]

  def new
    if params[:back]
      set_new_tweet_with_params
    else
      set_new_tweet
    end
  end

  def confirm
    if params[:tweet].nil?
      set_new_tweet
      render action: :new
    else
      set_new_tweet_with_params
      render :new if @tweet.invalid?
    end
  end

  def create
    set_new_tweet_with_params
    if @tweet.save
      flash[:notice] = "Tweeted."
      redirect_to :root
    else
      flash[:danger] = "Tweet failed!!"
      redirect_to :root
    end
  end

  def index
    @tweets = Tweet.all.order(updated_at: :desc)
  end

  def destroy
    @tweet.destroy
    flash[:danger] = "Tweet deleted."
    redirect_to :root
  end

  def update
    if @tweet.update(tweet_params)
      flash[:notice] = "Tweet updated."
      redirect_to :root
    else
      flash.now[:danger] = "Tweet update failed!!"
      render :root
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def set_new_tweet
    @tweet = Tweet.new
  end

  def set_new_tweet_with_params
    @tweet = Tweet.new(tweet_params)
  end
end
