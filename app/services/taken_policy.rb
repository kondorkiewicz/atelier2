class TakenPolicy

  def initialize(user:, book:)
    @user = user
    @book = book
  end

  def applies?
    not_taken? && ( available_for_user?(user) || book.reservations.empty? )
  end

  private

  attr_accessor :user, :book

  def not_taken?
    book.reservations.find_by(status: 'TAKEN').nil?
  end

  def available_for_user?(user)
    if available_reservation.present?
      available_reservation.user == user
    else
      pending_reservations.nil?
    end
  end

  def pending_reservations
    book.reservations.find_by(status: 'PENDING')
  end

  def available_reservation
    book.reservations.find_by(status: 'AVAILABLE')
  end

end