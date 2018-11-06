class CustomersController < ApplicationController
  def index
    customers = Customer.all
    render json: jsonify(customers)
  end
end

private

  def customer_params
    params.require(:customer).permit(:name, :registered_at, :address, :city, :state, :postal_code, :phone)
  end

  def jsonify(customer_data)
    return customer_data.as_json( only: [:id, :name, :registered_at, :address, :city, :state, :postal_code, :phone] )
  end
