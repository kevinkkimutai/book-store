class OrdersController < ApplicationController
    before_action :authorize_request
        before_action :set_order, only: [:show, :update, :destroy]
    def create
        @order = @current_user.orders.build(order_params)
        @order.total_price = @order.quantity * @order.book.price
        if @order.save
          render json:{message: "Order created successfully",order: @order, status: :created}
        else
          render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
        end
      end
    
      def index
        @orders = @current_user.orders
        render json: @orders, status: :ok
      end
       # DELETE /orders/1
       def destroy
        @order.destroy
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_order
        @order = @current_user.orders.find(params[:id])
      end
      private
      
  def order_params
   params.require(:order).permit(:book_id, :quantity, :total_price)
  end
end
