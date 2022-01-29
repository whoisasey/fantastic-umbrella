class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :date
      t.integer :employeeId
      t.integer :hoursWorked
      t.string :jobGroup

      t.timestamps
    end
  end
end
