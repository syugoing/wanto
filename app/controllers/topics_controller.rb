class TopicsController < ApplicationController
  before_action :authenticate_user!
  PERMISSIBLE_ATTRIBUTES = %i(name picture picture_cache)

  def index
    @topics = Topic.all
    @topic = Topic.new
    @comments = Comment.all
    @comment = @topic.comments.build
    @topic_id = ""
    @users = User.all
  end

  def show
    @topic = Topic.find(params[:id])
    @comment = @topic.comments.build
    @comments = @topic.comments
    @topic_id = ""
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
    if params[:notification_id] != nil then
      Notification.find(params[:notification_id]).update(read: true)
    end
  end

  def new
    if params[:back]
      @topic = Topic.new(topics_params)
    else
      @topic = Topic.new
    end
  end

  def create
    @topic = Topic.new(topics_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topics_path, notice: "投稿しました。"
      NoticeMailer.sendmail_topic(@topic).deliver
    else
      render action: 'new'
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def update
    @topic = Topic.find(params[:id])
    @topic.update(topics_params)
    if @topic.save
      redirect_to topics_path, notice: "投稿を編集しました。"
    else
      render action: 'new'
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_path, notice: "投稿をを削除しました！"
  end

  private
    def topics_params
      params.require(:topic).permit(:content, :picture)
    end

end
