class ReportSongRightsAdmins < BaseReport

  attr_reader :report_title, :line_length, :report_string_continuation_indent

  def initialize
    @line_length = [Song.max_code_length, Song.max_name_length, Organization.max_code_length, Organization.max_name_length].sum + 6
    @report_title = 'Songs Rights Administrators'
    @report_string_continuation_indent = Song.max_code_length + Song.max_name_length + 4
  end


  def heading
    '%-*s  %-*s  %-*s  %-*s' %
        [Song.max_code_length,      '   Code',
         Song.max_name_length,      'Name',
         Organization.max_code_length, 'Admin Code',
         Organization.max_name_length, 'Rights Administrator Name']
  end


  def report_string
    report = StringIO.new
    report << "#{title_banner}#{heading}\n\n"
    Song.order(:name).all.each { |record| report << record_report_string(record) << "\n" }
    report << "\n\n"
    report.string
  end


  def record_report_string(record)
    rights_admins = record.rights_admin_orgs.order(:name).all.to_a || []
    code = rights_admins.empty? ? '?' : rights_admins.first.code
    name = rights_admins.empty? ? '?' : rights_admins.first.name
    sio = StringIO.new
    sio << '%-*s  %-*s  %-*s  %s' %
        [Song.max_code_length, record.code, Song.max_name_length, record.name,
         Organization.max_code_length, code, name]

    (rights_admins[1..-1] || []).each do |rights_admin|
      sio << "\n%-*s%-*s  %s" %
          [@report_string_continuation_indent, '', Song.max_code_length, rights_admin.code, rights_admin.name]
    end
    sio.string
  end

end