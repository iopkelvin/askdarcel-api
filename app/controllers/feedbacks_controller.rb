# frozen_string_literal: true

class FeedbacksController < ApplicationController
  before_action :load_source
  def index
    feedbacks = @feedback_source.feedbacks
    render json: FeedbackPresenter.present(feedbacks)
  end

  def create
    feedback = @feedback_source.feedbacks.new(feedbacks_params)
    if feedback.save
      render status: :created, json: 'Success!'
    else
      render json: feedback.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def load_source
    source_type, id = request.path.split('/')[1, 2]
    @feedback_source = source_type.classify.constantize.find(id)
  end

  def feedbacks_params
    params.require(:feedback).permit(:rating, :review)
  end
end