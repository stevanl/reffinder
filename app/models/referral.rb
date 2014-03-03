class Referral < ActiveRecord::Base
  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      referral = find_by_id(row["id"]) || new
      mappings = {"Domain" => "referrer", "Category" => "category", "Global Rank" => "global_rank", "Share" => "share", "Change" => "change"}
      parameters = ActionController::Parameters.new(Hash[row.to_hash.map {|k, v| [mappings[k], v] }])
      # raise Hash[row.to_hash.map {|k, v| [mappings[k], v] }].inspect
      file_str = file.original_filename.split('Referrals-')[1].split('-(')
      site = file_str[0]
      # raise parameters.permit(:site, :referrer, :global_rank, :category, :share, :change).inspect
      referral.update(parameters.permit(:site, :referrer, :global_rank, :category, :share, :change))
      referral.update_attributes(:site => site)
      referral.update_attributes(:referrer => row.first[1])
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
