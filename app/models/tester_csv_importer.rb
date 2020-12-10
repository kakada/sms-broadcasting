require "csv"

class TesterCsvImporter
  attr_accessor :broadcast

  def initialize broadcast = nil
    @broadcast = broadcast
  end

  def import csv_file
    return if !csv_file.present?

    ::CSV.foreach(csv_file.path, headers: true, encoding: "bom|utf-8") do |row|
      proceed row.to_hash
    end
  end

  private

  def proceed row
    return if !valid?(row)

    tester = Tester.new
    tester.phone_number = row["phone_number"]
    tester.age = row["age"]
    tester.gender = row["gender"]
    tester.lab_code = row["lab_code"]
    tester.broadcast = broadcast
    tester.save
  rescue
    Rails.logger.info "Unprocessible row: #{row}"
  end

  def valid? row
    row['phone_number'].present? & row['lab_code'].present?
  end
end
