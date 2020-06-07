class Song < ApplicationRecord

  has_and_belongs_to_many :movies
  has_and_belongs_to_many :genres
  has_and_belongs_to_many :performers
  has_and_belongs_to_many :writers
  has_and_belongs_to_many :rights_admin_orgs, class_name: 'Organization'
  has_many :song_plays

  validates_length_of :code, maximum: max_code_length
  validates :name, presence: true
  validates :name, uniqueness: true

  def self.as_report_string
    report = StringIO.new
    report << "          Songs\n\n"
    report << '   Code           Name'
    report << "\n\n"
    all.each { |record| report << record.as_report_string << "\n" }
    report.string
  end

  def as_report_string
    '%-14s %s' % [code, name]
  end


end
