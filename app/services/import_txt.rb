class ImportTxt < ApplicationService

  def initialize file, user
    @file = file
    @user = user
  end

  def call
    # unless self.validateExtensiopn
    #   return false
    # end

    #file_name = self.salve_on_disc
    response = self.salve_on_db(@file)
  end

  #def salve_on_disc
   # txt_file_path = "public/"
   # file_name = "dados_#{Time.now.to_i}.txt"
   # txt_file_path = File.join(Rails.root, txt_file_path, file_name)
   # File.open(txt_file_path, "wb") do |f|
   #   f.write(@file.read)
   #   #f.close
   # end

   # file_name
  #end

  def salve_on_db file
    response = false

    open("#{Rails.root}/public/#{file.to_s}") do |file|
      file.each_with_index do |line, i|
        next if i == 0
        column = line.split("<")
        
        post = Post.new
        post.title = column[0]
        post.description = column[1]
        post.user_id = @user
        post.save        
        response = true
      end
    end
    response
  end

  def validateExtensiopn
    allow_extensions = ['.txt']
    true if allow_extensions.include? File.extname(@file.original_filename)
  end
end