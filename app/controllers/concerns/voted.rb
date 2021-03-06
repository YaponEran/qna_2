module Voted
  extend ActiveSupport::Concern

  included do
    before_action :load_votable, only: [:vote_up, :vote_down, :vote_reset]
  end

  def vote_up
    render_errors("You are author of}") and return if current_user.author_of?(@votable)
    render_errors("Twise voted") and return unless @votable.vote_up!(current_user)

    render_json
  end

  def vote_down
    render_errors("You are author of") and return if current_user.author_of?(@votable)
    render_errors("Twise voted") and return unless @votable.vote_down!(current_user)

    render_json
  end

  def vote_reset
    render_errors("You are author of") and return if current_user.author_of?(@votable)
    render_errors("vote declaed") and return unless @votable.vote_reset!(current_user)

    render_json
  end

  private
  
  def load_votable
    @votable = module_klass.find(params[:id])
  end

  def render_json
    render json: { id: @votable.id, name: param_name(@votable), raiting: @votable.raiting }
  end
  
  def render_errors(msg)
    render json: { message: msg }, status: :forbidden
  end

  def param_name(item)
    item.class.name.underscore
  end

  def module_klass
    controller_name.classify.constantize
  end
end