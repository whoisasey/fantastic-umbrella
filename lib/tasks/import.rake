require 'csv'

namespace :import do

  desc "Import Employees from csv"
  task employees: :environment do
    # optional: this will destroy the db every rake and reset the key sequence. 
    # comment out if not needed
    # Employee.destroy_all
    # ActiveRecord::Base.connection.reset_pk_sequence!('employees')
    # puts "Cleaned previous database"
    # 
    filename = File.join Rails.root, 'time-report-42.csv'
    counter = 0
    CSV.foreach(filename, headers: true) do |row|
      employee = Employee.create(date: row['date'], hoursWorked: row['hoursWorked'], employeeId: row['employeeId'], jobGroup: row['jobGroup'])
      puts "#{id} - #{employee.errors.full_messages.join(",")}" if employee.errors.any?
      counter +=1 if employee.persisted?
    end

    puts "Imported #{counter} Employees"
  end
end