class User < ApplicationRecord
  include ActionView::Helpers::DateHelper

  has_and_belongs_to_many :friends,
                          class_name: 'User',
                          join_table: 'friendships',
                          foreign_key: 'user_id'

  validates :name, :username, presence: true
  validates :username, length: { minimum: 6 }
  validates :username, uniqueness: true
  validate :valid_birth_date?

  def add_friend(user)
    friends << user unless friends.include? user
  end

  def age
    distance_of_time_in_words_hash(Time.now, birth_date.to_time)[:years]
  end

  def valid_birth_date?
    if Date.today <= birth_date
      errors.add(:invalid_birth_date, 'Birth date cannot be in the present or future')
    end
  end
end
