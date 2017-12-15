class ReservedPolicy
  def initialize(user:, book:)
    @user = user
    @book = book
  end

  def applies?
    book.reservations.find_by(user: user, status: 'RESERVED').nil?
  end

  private

  attr_reader :user, :book
end
