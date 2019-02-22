class Api::V1::ProductsController < ApplicationController
    before_action :find_product, only: [:show, :update, :destroy]

    def index
        products = Product.all
        render json: products, status: :ok
    end

    def show
        if @product.nil?
            render json: {message: "Product not found"}, status: :not_found
        else
            render json: @product, status: :ok
        end
    end

    def create
        product = Product.new (product_params)
        if product.save
            render json: product, status: :created and return
        elsif product.nil_fields?
            error_status = :bad_request
        else
            error_status = :unprocessable_entity
        end

        render json: {message: 'Product not saved', errors: product.errors}, status: error_status
    end

    def update
        if @product.update(product_params)
            render json: @product, status: :ok and return
        elsif @product.nil_fields?
            error_status = :bad_request
        elsif
            error_status = :unprocessable_entity
        end

        render json: {message: 'Product not updated', errors: product.errors}, status: error_status
    end


    def destroy
        if @product.nil?
            render json: {message: "Product not found"}, status: :not_found
        else
            @product.destroy
        end
    end

    private
    def find_product
        @product = Product.find_by_id(params[:id])
    end

    def product_params
        params.permit(:name, :quantity)
    end

end
