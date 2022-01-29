require 'date'

class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show update destroy ]

  # GET /employees
  def index
    @employees = Employee.all

    # amountpaid: if id=1 hours worked between 1-15 or 16-31 x groupPay
    @employeelist = @employees.map do |employee|

      {
        :employeeId => employee.employeeId,
        :payPeriod => {
          :startDate => "01/01/2023",
          :endDate => "15/01/2023"
        },
        :amountPaid => findPay(employee.employeeId, employee.date, employee.hoursWorked, employee.jobGroup )
      }
     
    end
    render json: {
      payrollReport: {
        employeeReports: @employeelist
        }
      }
  end

  # GET /employees/1
  def show
    render json: @employee
  end

  # POST /employees
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      render json: @employee, status: :created, location: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      render json: @employee
    else
      render json: @employee.errors, status: :unprocessable_entity
    end
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def employee_params
      params.require(:employee).permit(:date, :employeeId, :hoursWorked, :jobGroup)
    end

    def find_groupPay(group)
      if group == "A"
        return 20
      else
        return 30
      end
    end

    def findPay( id, date, hours, group)
      @employees = Employee.all
      # p [id, date, hours, group]
      first_date = '15/11/2023'
      last_date = '30/11/2023'
      arr = (first_date .. last_date)
      # p first_date.class
    # return objects that match employee and is within date above
      employee = @employees.select{|k,v|
      k.employeeId == id 
      Date.parse(k.date) >= Date.parse(first_date) && Date.parse(k.date) <= Date.parse(last_date) 

      # return k.hoursWorked
      # return k.hoursWorked * find_groupPay(k.jobGroup)
      }

      # employee = @employees
      # .group_by{|val| val['employeeId']}
      # .map do |k,v|
      #   p v.sum {|val| val['hoursWorked']}
      # end

      # employee = @employees.group_by{|val| val['employeeId']}
      # * find_groupPay(group)
  # return only days worked for employee with id

      # find all days from employee 1 between 1-15 or 16-31
      # multiply by group
    end

    def find_startDate(date)  
      # first date = find first number at 01
      # last date = find first number at 15
     
      # findDate = @employees.select { |key,value| 
      #   startDate = key.date.split('/')[0].to_i
      #   # p startDate
      #   if startDate < 16
      #     p startDate
      #   end
      # }

      # p findDate
      # return date it doesn't match 16-31
        # p if date.include?(dates)
    end

    def find_endDate(date)
      endDate = date.split('/')[0].to_i
      # return date it doesn't match 16-31
        if (16..31) == endDate
          return endDate
        end
      return date
    end
  end