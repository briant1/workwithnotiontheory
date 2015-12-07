class UsersController < ApplicationController
  before_action :set_user, only: [:update]
  def update
    if @user.update(user_params)
      @user.submitted_at = DateTime.now
      @user.save
      str = "User submitted to work with us " + @user.name
      HTTParty.post "http://notiontheory.slack.com/services/hooks/slackbot?token=pXjkDiy5cCMuRCu5mjPsF9AA&channel=%23message", { body:  str }
      redirect_to  receipt_path
    end
  end

  def receipt

  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:users).permit(:project_heroku_url, :project_github_url)
  end
end
