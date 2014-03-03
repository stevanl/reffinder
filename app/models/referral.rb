class Referral < ActiveRecord::Base
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      referral = find_by_id(row["id"]) || new
      parameters = ActionController::Parameters.new(row.to_hash)
      referral.update(parameters.permit(:Domain, :Category, :Share, :Change))
      # referral.update(parameters.permit(:Domain, :Category, "Global Rank", :Share, :Change))
      referral.save!
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end
end
