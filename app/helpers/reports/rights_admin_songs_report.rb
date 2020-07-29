class RightsAdminSongsReport < HasManyReport

  def initialize
    super(
        title: 'Rights Administrator Songs',
        primary_ar_class: Organization,
        secondary_ar_class: Song,
        text_report_class_name: RightsAdminSongsTextReport
    )
    @report_type = 'rights_admins'
  end

  def populate
    @records = Organization.order(:name).all.map do |org|
      {
          name: org.name,
          songs: pluck_to_hash(org.songs.order(:name), :code, :name)
      }
    end
  end
end