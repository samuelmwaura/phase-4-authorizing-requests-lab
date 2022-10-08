class MembersOnlyArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  before_action :authorize
  #This means that before anny handle function in this controller, the aurthorize method is going to run amd check wheher thr requester client is logged in.
  #Is it is needed that any of the contollers skips the authentication, the skip_before_action method is used and the exact method to skip is indicate explicitly.
  #This is a way to authorize and to expose some resources to non-logged-in users and other specific ones to logged in users.

  def index
    articles = Article.where(is_member_only: true).includes(:user).order(created_at: :desc)
    render json: articles, each_serializer: ArticleListSerializer
  end

  def show
    article = Article.find(params[:id])
    render json: article
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end

  #Action to run before every action in this controller.
  def authorize
    render json:{error:"Not authorized"}, status: :unauthorized unless session.include?(:user_id)
  end

end
