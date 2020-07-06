class SongGenresReport < BaseReport

  attr_reader :records

  def initialize
    @records = Song.order(:name).map do |song|
      {
          code: song.code,
          name: song.name,
          genres: song.genres.order(:name).pluck(:name)
      }
    end

    def to_html
      headings = ['Code', 'Name', 'Genres']
      data = records.map do |record|
        [record[:code], record[:name], record[:genres].join(', ')]
      end
      table_data = records_to_html_table_data(data)
      html_report_table(headings, table_data)
    end
  end
end
