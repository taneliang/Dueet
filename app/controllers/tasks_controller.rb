class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @categories = Category.all
  end

  # GET /tasks/1/edit
  def edit
    @categories = Category.all
  end

  # POST /tasks
  # POST /tasks.json
  def create
    other_params, category_ids = task_params
    @task = Task.new(other_params)
    set_categories(category_ids, @task)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      other_params, category_ids = task_params

      # Set categories before updating the other params
      set_categories(category_ids, @task)

      if @task.update(other_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      all_params = params.require(:task).permit(:title, :due_date, :completed, categories: [])
      return all_params.except(:categories), all_params[:categories]
    end

    def set_categories(category_ids, task)
      if not category_ids
        return
      end

      @task.categories = [] # Clear as we don't want stray categories that have been deselected

      category_ids.each do |category_id|
        if category_id.empty?
          next
        end
        category = Category.find(category_id)
        if category.valid? and not @task.categories.include?(category)
          @task.categories.push(category)
        end
      end
    end
end
