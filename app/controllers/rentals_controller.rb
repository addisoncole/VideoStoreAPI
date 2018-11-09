class RentalsController < ApplicationController

  def checkout
    @rental = Rental.new(rental_params)
    if @rental.save
      if @rental.check_movie_availability?

        @rental.set_rental_dates

        render json: { id: @rental.id }
      else
        render_error(:bad_request, { movie_inventory: ["Movie out of stock"]})
      end
    else
      render_error(:bad_request, @rental.errors.messages)
    end
  end

  def checkin
    rentals = Rental.where(customer_id: params[:customer_id] )
    @rental = rentals.find_by(movie_id: params[:movie_id])
    if @rental
      @rental.update(checked_out?: false)

      render json: { id: @rental.id }
    else
      render_error(:not_found, { rental: ["Rental not found"]})
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
    # params.require(:rental).permit(:customer, :movie, :checkout_date, :due_date)
  end
end
