class ShowfollowsController < ApplicationController
  def index
    @showfollows = Showfollow.all.order({ :created_at => :desc })

    render({ :template => "showfollows/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @showfollow = Showfollow.where({:id => the_id }).at(0)

    render({ :template => "showfollows/show.html.erb" })
  end

  def create
    @showfollow = Showfollow.new
    @showfollow.show_id = params.fetch("query_show_id")
    @showfollow.attendee_id = params.fetch("query_attendee_id")

    if @showfollow.valid?
      @showfollow.save
      redirect_to("/showfollows", { :notice => "Showfollow created successfully." })
    else
      redirect_to("/showfollows", { :notice => "Showfollow failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @showfollow = Showfollow.where({ :id => the_id }).at(0)

    @showfollow.show_id = params.fetch("query_show_id")
    @showfollow.attendee_id = params.fetch("query_attendee_id")

    if @showfollow.valid?
      @showfollow.save
      redirect_to("/showfollows/#{@showfollow.id}", { :notice => "Showfollow updated successfully."} )
    else
      redirect_to("/showfollows/#{@showfollow.id}", { :alert => "Showfollow failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @showfollow = Showfollow.where({ :id => the_id }).at(0)

    @showfollow.destroy

    redirect_to("/showfollows", { :notice => "Showfollow deleted successfully."} )
  end
end
