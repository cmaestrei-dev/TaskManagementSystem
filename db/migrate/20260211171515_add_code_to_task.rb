class AddCodeToTask < ActiveRecord::Migration[8.1]
  def change
    add_column :tasks, :code, :string
  end
end
