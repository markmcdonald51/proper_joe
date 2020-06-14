class MediaLinksController < ApplicationController
  before_action :set_media_link, only: [:show, :edit, :update, :destroy]

  # GET /media_links
  # GET /media_links.json
  def index
    @media_links = MediaLink.all
  end

  # GET /media_links/1
  # GET /media_links/1.json
  def show
  end

  # GET /media_links/new
  def new
    @media_link = MediaLink.new
  end

  # GET /media_links/1/edit
  def edit
  end

  # POST /media_links
  # POST /media_links.json
  def create
    @media_link = MediaLink.new(media_link_params)

    respond_to do |format|
      if @media_link.save
        format.html { redirect_to @media_link, notice: 'Media link was successfully created.' }
        format.json { render :show, status: :created, location: @media_link }
      else
        format.html { render :new }
        format.json { render json: @media_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /media_links/1
  # PATCH/PUT /media_links/1.json
  def update
    respond_to do |format|
      if @media_link.update(media_link_params)
        format.html { redirect_to @media_link, notice: 'Media link was successfully updated.' }
        format.json { render :show, status: :ok, location: @media_link }
      else
        format.html { render :edit }
        format.json { render json: @media_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media_links/1
  # DELETE /media_links/1.json
  def destroy
    @media_link.destroy
    respond_to do |format|
      format.html { redirect_to media_links_url, notice: 'Media link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_media_link
      @media_link = MediaLink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def media_link_params
      params.require(:media_link).permit(:text, :link, :linkableable_id, :linkableable_type, :position)
    end
end
