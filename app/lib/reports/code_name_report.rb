class CodeNameReport < BaseReport

  attr_reader :ar_class, :records, :tuples

  def initialize(ar_class)
    @ar_class = ar_class
    @tuples = ar_class.order(:name).pluck(:code, :name)
    @records = tuples.map do |tuple|
      { code: tuple[0], name: tuple[1] }
    end
  end

  def to_html
    table_data = records_to_html_table_data(tuples)
    html_report_table(%w{Code Name}, table_data)
  end

  def to_raw_text
    CodeNameTextReport.new(ar_class, records).report_string
  end
end
