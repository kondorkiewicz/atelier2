namespace :reservation_expires do
  desc "send mail when reservation expires"
  task send_mail: :environment do
    reservations = Reservation.where('DATE(expires_at) = ? AND status = ?', Date.tomorrow, 'TAKEN')
    reservations.each do |reservation|
      BooksMailer.book_return(reservation).deliver_now
    end
  end
end
