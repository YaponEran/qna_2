class AttachmentsController < ApplicationController

  before_action :authenticate_user!, only: [:destroy]
  before_action :find_attachment, only: [:destroy]

  def destroy
    if current_user.author_of?(@attachment.record)
      @attachment.purge
    else
      redirect_to root_path
    end
  end

  private
  def find_attachment
    @attachment = ActiveStorage::Attachment.find(params[:id])
  end
end
