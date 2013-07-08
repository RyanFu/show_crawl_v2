# encoding: utf-8
class GoogleDocAccessor

  require "google_drive"

  def initialize
    init_session  
  end

  def init_session
    # Logs in.
    # You can also use OAuth. See document of
    # GoogleDrive.login_with_oauth for details.
    @session = GoogleDrive.login("jumplives@gmail.com", "jumplife")
  end

  def load_shows_from_doc_to_db sheet_num
    #type: 0
    #@ws = nil
    (1..sheet_num).each do |index|
      @ws = @session.spreadsheet_by_key("0AgG7-99tPbp5dGJGVXVjMUdYYlJld1FXbVdOLW9CR0E").worksheets[index]
      next if @ws == nil
      name = @ws.title
      type = TypeV2.where("name = ?", name)[0]
      next if type == nil
      #puts "Type id: " + type.id.to_s
      #puts "Type name: " + type.name
      
      rows = @ws.num_rows
      (2..rows).each do |row|

        name = @ws[row, 2]
        poster_url = @ws[row, 3]
        link = @ws[row, 4]

        next if ShowV2.where("name = ?", name)[0]

        show = ShowV2.new
        show.name = name
        show.type_id = type.id
        show.poster_url = poster_url
        show.link = link

        show.save

        @ws[row, 1] = show.id
      end
    @ws.save()
    end
  end

end