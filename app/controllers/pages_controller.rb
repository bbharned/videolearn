class PagesController < ApplicationController
	before_action :require_user, except: [:index, :maintenance]
    before_action :require_admin, only: [:stats, :newusers]

    def index
        @user = User.new
        redirect_to dashboard_path if logged_in?
    end

    def maintenance

    end

    def dropbox
        
    end

    def stats
        @users = User.all
        @allwatched = UserVideo.all
        @allquizzed = UserQuiz.all
        @prodbadges = UserBadge.where(productivity: true)
        @visbadges = UserBadge.where(visualization: true)
        @secbadges = UserBadge.where(security: true)
        @mobbadges = UserBadge.where(mobility: true)
        @watchedthisweek = UserVideo.where(created_at: 1.week.ago..Date.tomorrow)
        @usersthisweek = User.where(created_at: 1.week.ago..Date.tomorrow)
        @quizthisweek = UserQuiz.where(created_at: 1.week.ago..Date.tomorrow)
        @watchedthismonth = UserVideo.where(created_at: 1.month.ago..Date.tomorrow)
        @usersthismonth = User.where(created_at: 1.month.ago..Date.tomorrow)
        @quizthismonth = UserQuiz.where(created_at: 1.month.ago..Date.tomorrow)
        @watchedthisquarter = UserVideo.where(created_at: 3.months.ago..Date.tomorrow)
        @usersthisquarter = User.where(created_at: 3.months.ago..Date.tomorrow)
        @quizthisquarter = UserQuiz.where(created_at: 3.months.ago..Date.tomorrow)
    end

    def newusers
        @yearlynewusers = User.where(created_at: Date.today.at_beginning_of_year..Date.tomorrow).order(:created_at)
        @jannewusers = User.where(created_at: Date.today.at_beginning_of_year..(Date.today.at_beginning_of_year + 1.month)).order(:created_at)
        @febnewusers = User.where(created_at: (Date.today.at_beginning_of_year + 1.month)..(Date.today.at_beginning_of_year + 2.months)).order(:created_at)
        @marnewusers = User.where(created_at: (Date.today.at_beginning_of_year + 2.month)..(Date.today.at_beginning_of_year + 3.months)).order(:created_at)
        @aprilnewusers = User.where(created_at: (Date.today.at_beginning_of_year + 3.month)..(Date.today.at_beginning_of_year + 4.months)).order(:created_at)
        @maynewusers = User.where(created_at: (Date.today.at_beginning_of_year + 4.month)..(Date.today.at_beginning_of_year + 5.months)).order(:created_at)
        @junenewusers = User.where(created_at: (Date.today.at_beginning_of_year + 5.month)..(Date.today.at_beginning_of_year + 6.months)).order(:created_at)
        @julynewusers = User.where(created_at: (Date.today.at_beginning_of_year + 6.month)..(Date.today.at_beginning_of_year + 7.months)).order(:created_at)
        @augnewusers = User.where(created_at: (Date.today.at_beginning_of_year + 7.month)..(Date.today.at_beginning_of_year + 8.months)).order(:created_at)
        @septnewusers = User.where(created_at: (Date.today.at_beginning_of_year + 8.month)..(Date.today.at_beginning_of_year + 9.months)).order(:created_at)
        @octnewusers = User.where(created_at: (Date.today.at_beginning_of_year + 9.month)..(Date.today.at_beginning_of_year + 10.months)).order(:created_at)
        @novnewusers = User.where(created_at: (Date.today.at_beginning_of_year + 10.month)..(Date.today.at_beginning_of_year + 11.months)).order(:created_at)
        @decnewusers = User.where(created_at: (Date.today.at_beginning_of_year + 11.month)..(Date.today.at_beginning_of_year + 12.months)).order(:created_at)
        


        @export = User.where(id: @yearlynewusers.ids)
        respond_to do |format|
          format.html
          format.csv { send_data @export.to_csv, filename: "Monthly New Users-#{Date.today}.csv" }
        end

    end

    def dashboard
        @videos = Video.includes(:video_categories).order("video_categories.category_id asc")
    	@user = User.find(current_user.id)
        # put in badge detection here.
        @badge = UserBadge.where(user_id: @user.id).take
        
        @prod_category = Category.where(name: "Productivity").take
        @prod_videos = @prod_category.videos.all
        
        @vis_category = Category.where(name: "Visualization").take
        @vis_videos = @vis_category.videos.all

        @sec_category = Category.where(name: "Security").take
        @sec_videos = @sec_category.videos.all
        
        @mob_category = Category.where(name: "Mobility").take
        @mob_videos = @mob_category.videos.all

        
        #### Productivity Badge ####
        @catprod_user_watch = 0
        @catprod_user_quiz = 0
        @prod_videos.each do |video|
            @uvquery = UserVideo.where(user_id: @user.id, video_id: video.id)
            if @uvquery != [] 
                @catprod_user_watch += 1
            end
            video.quizzes.each do |quiz|
                @uqquery = UserQuiz.where(user_id: @user.id, quiz_id: quiz.id)
                    if @uqquery != []
                        @catprod_user_quiz += 1
                    end
                end
        end
        
        if (@prod_videos.count == @catprod_user_watch) && (@catprod_user_quiz == @prod_videos.count) && @catprod_user_watch > 0
            if  @badge == nil
                @newprodbadge = UserBadge.new(user_id: @user.id, productivity: true)
               if @newprodbadge.save
                    #when productivity badge is awarded
                    flash[:success] = "You earned your PRODUCTIVITY badge!"
                    redirect_to dashboard_path 
               else

               end
            elsif @badge != nil && !@badge.productivity
                if @badge.update(productivity: true)
                    flash[:success] = "You earned your PRODUCTIVITY badge!"
                    redirect_to dashboard_path
                else
                    flash[:danger] = "There was a problem awarding your badge."
                    redirect_to dashboard_path
                end
            end 
        end


        #### Visualization Badge ####
        @catvis_user_watch = 0
        @catvis_user_quiz = 0
        @vis_videos.each do |video|
            @uvvquery = UserVideo.where(user_id: @user.id, video_id: video.id)
            if @uvvquery != [] 
                @catvis_user_watch += 1
            end
            video.quizzes.each do |quiz|
                @uvqquery = UserQuiz.where(user_id: @user.id, quiz_id: quiz.id)
                    if @uvqquery != []
                        @catvis_user_quiz += 1
                    end
                end
        end
        
        if (@vis_videos.count == @catvis_user_watch) && (@catvis_user_quiz == @vis_videos.count) && @catvis_user_watch > 0
            if  @badge == nil
                @newvisbadge = UserBadge.new(user_id: @user.id, visualization: true)
               if @newvisbadge.save
                    #when visualization badge is awarded
                    flash[:success] = "You earned your VISUALIZATION badge!"
                    redirect_to dashboard_path 
               else

               end
            elsif @badge != nil && !@badge.visualization
                if @badge.update(visualization: true)
                    flash[:success] = "You earned your VISUALIZATION badge!"
                    redirect_to dashboard_path
                else
                    flash[:danger] = "There was a problem awarding your badge."
                    redirect_to dashboard_path
                end
            end 
        end
        

        #### Security Badge ####

            #Coming Soon#

        #### Mobility Badge ####

            #Coming Soon#


    end

    

    private

    def require_admin
        if !logged_in? || (logged_in? && !current_user.admin?)
            flash[:danger] = "Only Admins can perform that action"
            redirect_to root_path
        end
    end
    

end