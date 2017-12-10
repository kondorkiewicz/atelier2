class BooksMailer < ApplicationMailer

  def book_taken(reservation)
    @user = reservation.user
    @book = reservation.book
    @reservation = reservation

    mail(to: @user.email, subject: "Reservation for #{@book.title}")
  end

end