class KanbansController < ApplicationController
  before_action :set_kanban, only: [:show, :destroy]

  unless Rails.env.test?
    before_action :authenticate_user
    before_action :set_user_kanban, only: [:show]
  end

  # TODO remove after
  # GET /kanbans
  # GET /kanbans.json
  #def index
  #  @kanbans = Kanban.all
  #end

  # GET /kanbans/1
  # GET /kanbans/1.json
  def show
    issues_group_by_label = @kanban.issues_group_by_label(project_issues)

    @label_groups = []
    @kanban.labels.each do |label|
      @label_groups << {
          label:  label,
          issues: issues_group_by_label[label.id] || []
      }
    end
  end

  # TODO remove after
  # GET /kanbans/new
  #def new
  #  @kanban = Kanban.new
  #end

  # TODO remove after
  # GET /kanbans/1/edit
  #def edit
  #end

  # POST /kanbans
  # POST /kanbans.json
  def create
    @kanban = Kanban.new(kanban_params)

    respond_to do |format|
      if @kanban.save
        format.html { redirect_to @kanban, notice: 'Kanban was successfully created.' }
        format.json { render action: 'show', status: :created, location: @kanban }
      else
        format.html { render action: 'new' }
        format.json { render json: @kanban.errors, status: :unprocessable_entity }
      end
    end
  end

  # TODO remove after
  # PATCH/PUT /kanbans/1
  # PATCH/PUT /kanbans/1.json
  #def update
  #  respond_to do |format|
  #    if @kanban.update(kanban_params)
  #      format.html { redirect_to @kanban, notice: 'Kanban was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @kanban.errors, status: :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /kanbans/1
  # DELETE /kanbans/1.json
  def destroy
    @kanban.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kanban
      @kanban = Kanban.friendly.find(params[:id])
    end

    def set_user_kanban
      @user_kanban = UserKanban.new(current_user, @kanban) if current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kanban_params
      params.require(:kanban).permit(:gitlab_project_id, :name)
    end

    def project_issues
      @user_kanban.issues
    end
end
