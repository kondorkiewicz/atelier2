class BooksMailer < ApplicationMailer

  def book_taken(reservation)
    @user = reservation.user
    @book = reservation.book
    @reservation = reservation

    mail(to: @user.email, subject: "Reservation for #{@book.title}")
  end

  def book_return(book)
    @book = book
    @reservation = book.reservations.find_by(status: "TAKEN")
    @borrower = @reservation.user

    mail(to: @borrower.email, subject: "Upływa termin zwrotu książki #{@book.title}")
  end

  def book_reserved(book)
    @book = book
    @reservation = book.reservations.find_by(status: 'RESERVED')
    return if !@reservation
    @borrower = @reservation.user

    mail(to: @borrower.email, subject: "Upływa termin zwrotu książki #{@book.title}")
  end

end