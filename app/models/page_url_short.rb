class PageUrlShort < ApplicationRecord
  validates_presence_of :origin_url
  validates_uniqueness_of :origin_url

  scope :order_by_view_counter, -> { order(view_counter: :desc) }

  ALPHABET =
  'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'.split(//)

  before_create :short_url

  def sum_view_counter
    increment!(:view_counter)
  end

  private

  def short_url
    self.redirect_url = bijective_encode(PageUrlShort.last&.id || 1)
  end

  def bijective_encode(i)
    # from http://refactormycode.com/codes/125-base-62-encoding
    # with only minor modification
    return ALPHABET[0] if i == 0
    s = ''
    base = ALPHABET.length
    while i.positive?
      s << ALPHABET[i.modulo(base)]
      i /= base
    end
    s.reverse
  end
end
