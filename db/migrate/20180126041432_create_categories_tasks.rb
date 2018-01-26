class CreateCategoriesTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :categories_tasks do |t|
      t.references :category, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
