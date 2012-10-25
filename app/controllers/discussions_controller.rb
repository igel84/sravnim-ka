class DiscussionsController < ApplicationController
  before_filter :check_admin, only: [:change_visible]

  def index
    if current_user && current_user.admin?
      @discussions = Discussion.roots
    else
      @discussions = Discussion.roots.where(visible: true)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @discussions }
    end
  end

  def change_visible
    @discussion = Discussion.find(params[:id])
    @discussion.update_attributes(visible: (!@discussion.visible))
    redirect_to discussions_url
  end

  # GET /discussions/1
  # GET /discussions/1.json
  def show
    @discussion = Discussion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @discussion }
    end
  end

  # GET /discussions/new
  # GET /discussions/new.json
  def new
    @discussion = Discussion.new(parent_id: params[:parent_id])
  end

  # GET /discussions/1/edit
  def edit
    @discussion = Discussion.find(params[:id])
  end

  # POST /discussions
  # POST /discussions.json
  def create
    params[:discussion][:user_id] = current_user.id if current_user
    @discussion = Discussion.new(params[:discussion])
    @discussion.save
    respond_to do |format|
      format.js { render 'create' } 
      format.html { redirect_to discussions_url }
    end
  end

  # PUT /discussions/1
  # PUT /discussions/1.json
  def update
    @discussion = Discussion.find(params[:id])

    respond_to do |format|
      if @discussion.update_attributes(params[:discussion])
        format.html { redirect_to @discussion, notice: 'Discussion was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @discussion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /discussions/1
  # DELETE /discussions/1.json
  def destroy
    Discussion.find(params[:id]).destroy if current_user && current_user.admin? #(current_user.admin? || Discussion.find(params[:id]).user == current_user)
    redirect_to discussions_url
  end

  private
  def check_admin
    if !current_user || !current_user.admin?
      redirect_to :root
    end
  end
end
