class CommentsController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.creator = current_user

		if @comment.save
			flash[:notice] = "Your comment was added."
			redirect_to post_path(@post)
		else
			render 'posts/show'
		end
	end

	def vote
		comment=Comment.find(params[:id])
		vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    	
    	if vote.valid?
    	flash[:notice] = "Your vote was counted."
    	else
    	flash[:error] = "You cannot vote on this comment twice."
    	end
    	redirect_to :back
  	end
end
