class AdviceController < ApplicationController
  def create
    openai_service = OpenaiService.new
    message = params[:message]
    advice = openai_service.get_advice(message)

    render json: { advice: advice }
  rescue StandardError => e
    render json: { error: "An error occurred: #{e.message}" }, status: :internal_server_error
  end
end
