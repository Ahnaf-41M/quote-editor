class Quote < ApplicationRecord
  validates :name, presence: true

  # later_to makes broadcasting part asynchronous using background jobs
  after_create_commit do
    broadcast_prepend_later_to(
      "quotes",
      partial: "quotes/quote",
      locals: { quote: self },
      target: "quotes"
    )
  end
  after_update_commit -> { broadcast_replace_later_to "quotes" }
  after_destroy_commit -> { broadcast_remove_to "quotes" } # broadcast_remove_later_to method does not exist

  # Above three callbacks are equivalent to the following single line
  # broadcasts_to ->(quote) { "quotes" }, inserts_by: :prepend
end
