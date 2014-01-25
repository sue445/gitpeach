class KanbansController < ApplicationController
  before_action :set_kanban, only: [:show, :destroy, :edit, :update, :sync]

  unless Rails.env.test?
    before_action :authenticate_user
    before_action :set_user_kanban, only: [:show, :sync]
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

    done_label = @kanban.labels.done.first

    @label_groups = []
    @kanban.labels.each do |label|
      issues = issues_group_by_label[label.id] || []
      if label == done_label
        # reject old closed tasks
        issues = issues.reject{|issue| issue.updated_at < 1.week.ago }
      end

      @label_groups << {
          label:  label,
          issues: issues
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
  def edit
    @labels = @kanban.labels.map{|label| label.attributes.with_indifferent_access }
  end

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

  # PATCH/PUT /kanbans/1
  # PATCH/PUT /kanbans/1.json
  def update
    is_all_success = true

    Label.transaction do
      param_label_ids = params[:labels].inject([]){|array, label_params| array << label_params[:id]; array }.compact.map(&:to_i)
      @kanban.labels.each do |label|
        label.destroy unless param_label_ids.include?(label.id)
      end

      params[:labels].each_with_index do |label_params, index|
        # for checked -> unchecked
        label_params[:is_backlog_issue] = false unless label_params.has_key?(:is_backlog_issue)
        label_params[:is_close_issue]   = false unless label_params.has_key?(:is_close_issue)

        label_params[:disp_order] = index
        if label_params[:id].blank?
          label = @kanban.labels.build(label_params)
          is_all_success &= label.save
        else
          label = @kanban.labels.find(label_params[:id])
          is_all_success &= label.update(label_params.reject{|k,v| k == :id })
        end

        label.errors.each do |attribute, error|
          @kanban.errors[attribute] = error
        end
      end
    end

    if is_all_success
      redirect_to edit_kanban_path(@kanban), notice: 'Kanban was successfully updated.'
    else
      @labels = params[:labels]
      render action: 'edit'
    end
  end

  # DELETE /kanbans/1
  # DELETE /kanbans/1.json
  def destroy
    @kanban.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  def sync
    @kanban.gitlab_project_id = @user_kanban.project.id
    @kanban.name              = @user_kanban.project.path_with_namespace
    @kanban.slug              = nil

    if @kanban.save
      redirect_to edit_kanban_path(@kanban), notice: 'Kanban was synchronized with Gitlab.'
    else
      redirect_to edit_kanban_path(@kanban), error: 'Failed synchronized with Gitlab.'
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
