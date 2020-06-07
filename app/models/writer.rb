class Writer < ApplicationRecord

  has_and_belongs_to_many :songs

  validates_length_of :code, maximum: max_code_length
  validates_length_of :name, maximum: max_name_length
  validates :name, presence: true
  validates :name, uniqueness: true

end
