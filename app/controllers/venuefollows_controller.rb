class VenuefollowsController < ApplicationController
  def index
    @venuefollows = Venuefollow.all.order({ :created_at => :desc })

    render({ :template => "venuefollows/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @venuefollow = Venuefollow.where({:id => the_id }).at(0)

    render({ :template => "venuefollows/show.html.erb" })
  end

  def create
    @venuefollow = Venuefollow.new
    @venuefollow.venue_id = params.fetch("query_venue_id")
    @venuefollow.fan_id = params.fetch("query_fan_id")

    if @venuefollow.valid?
      @venuefollow.save
      redirect_to("/venuefollows", { :notice => "Venuefollow created successfully." })
    else
      redirect_to("/venuefollows", { :notice => "Venuefollow failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @venuefollow = Venuefollow.where({ :id => the_id }).at(0)

    @venuefollow.venue_id = params.fetch("query_venue_id")
    @venuefollow.fan_id = params.fetch("query_fan_id")

    if @venuefollow.valid?
      @venuefollow.save
      redirect_to("/venuefollows/#{@venuefollow.id}", { :notice => "Venuefollow updated successfully."} )
    else
      redirect_to("/venuefollows/#{@venuefollow.id}", { :alert => "Venuefollow failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @venuefollow = Venuefollow.where({ :id => the_id }).at(0)

    @venuefollow.destroy

    redirect_to("/venuefollows", { :notice => "Venuefollow deleted successfully."} )
  end
end
