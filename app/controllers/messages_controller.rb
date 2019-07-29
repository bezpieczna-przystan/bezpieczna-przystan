# frozen_string_literal: true

class MessagesController < ApplicationController
  invisible_captcha only: :create, honeypot: :subtitle
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.valid?
      MessageMailer.contact(@message).deliver_now
      redirect_to new_message_url
      flash[:notice] = 'Dziękujemy za Twoją wiadomość, odezwiemy się najszybciej jak to możliwe.'
    else
      flash[:notice] = 'Nie udało się wysłać wiadomości. Sprawdź błędy i spróbuj ponownie.'
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :phone_number, :body)
  end
end
