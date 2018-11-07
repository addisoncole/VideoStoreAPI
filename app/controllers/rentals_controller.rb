class RentalsController < ApplicationController

  def checkout
    @rental = Rental.new(rental_params)
    if @rental.check_movie_availability?

      @rental.set_rental_dates

      if @rental.save
        render json: { id: @rental.id }
      else
        render_error(:bad_request, @rental.errors.messages)
      end
    else
      render_error(:bad_request, movie_inventory: {['movie unavailable'})
    end
  end

  private

  def rental_params
    params.permit(:customer_id, :movie_id)
    # params.require(:rental).permit(:customer, :movie, :checkout_date, :due_date)
  end
end