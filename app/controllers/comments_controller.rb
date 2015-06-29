class CommentsController < ApplicationController

  def index
    @comments = Comments.where('id > ?', params[:after_id].to_i).order('created_at DESC')
  end

  def new
    @comment = Comment.new
    @comments = Comment.order('created_at DESC')
  end

  def create
    respond_to do |format|
      if current_user
        @comment = current_user.comments.build(comment_params)
        if @comment.save
          flash[:success] = "Your comment was successfully saved."
        else
          flash[:error] = "Your comment wasn't saved."
        end
        format.html { redirect_to root_url }
        format.js
      else
        format.html { redirect_to root_url }
        format.js { render nothing: true}
      end
    end
  end


  private

    def comment_params
      params.require(:comment).permit(:body)
    end
end
