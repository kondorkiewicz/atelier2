class Book < ApplicationRecord
  has_many :reservations
  has_many :borrowers, through: :reservations, source: :user
  belongs_to :category

  # statuses: AVAILABLE, TAKEN, RESERVED, EXPIRED, CANCELED, RETURNED

  def category_name
    category.try(:name)
  end

  def category_name=(name)
    self.category = Category.where(name: name).first_or_initialize
  end

  def can_take?(user)
    ::TakenPolicy.new(user: user, book: self).applies?
  end

  def take(user)
    return unless ::TakenPolicy.new(user: user, book: self).applies?

    if available_reservation.present?
      available_reservation.update_attributes(status: 'TAKEN')
    else
      reservations.create(user: user, status: 'TAKEN')
    end
  end

  def available_reservation
    reservations.find_by(status: 'AVAILABLE')
  end

  def give_back
    ActiveRecord::Base.transaction do
      reservations.find_by(status: 'TAKEN').update_attributes(status: 'RETURNED')
      next_in_queue.update_attributes(status: 'AVAILABLE') if next_in_queue.present?
    end
  end

  def reserve(user)
    return unless ::ReservedPolicy.new(user: user, book: self).applies?

    reservations.create(user: user, status: 'RESERVED')
  end

  def cancel_reservation(user)
    reservations.where(user: user, status: 'RESERVED').order(created_at: :asc).first.update_attributes(status: 'CANCELED')
  end

  private

  def next_in_queue
    reservations.where(status: 'RESERVED').order(created_at: :asc).first
  end
end
