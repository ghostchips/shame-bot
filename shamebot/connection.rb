require 'google_drive'

module ShameBot; module Data;
  class Connection
            
    def write(args = {})
      worksheet['A1'] = args[:user]
      worksheet.save
    end
    
    def load_worksheet
      worksheet.rows
    end
    
    private
    
    def session(config = 'config.json')
      GoogleDrive::Session.from_service_account_key(config)
    end
    
    def worksheet(title = 'Wall of Shame')
      session.spreadsheet_by_title(title).worksheets.first
    end
    
  end
end; end
