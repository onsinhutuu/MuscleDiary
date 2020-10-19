class ContactsController < ApplicationController
  before_action :authenticate_user!
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = current_user.id
    if @contact.save
      redirect_to muscles_path
      flash[:notice] = 'お問い合わせを送信しました。'
    else
      redirect_to request.referer
      flash[:notice] = '全て入力して下さい'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:title, :body, :reply)
  end
end
