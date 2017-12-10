class BookExpirationWorker
  include Sidekiq::Worker

  def perform(book_id)
    @book = Book.find(book_id)

    BooksMailer.book_return(@book).deliver
    BooksMailer.book_reserved(@book).deliver
  end
end