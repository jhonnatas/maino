class ImportTxt < ApplicationService

  def initialize file, user
    @file = file
    @user = user
  end

  def call
    # unless self.validate_extension
    #   return false
    # end
    salve_on_db
  end

  def salve_on_db 
    response = false

    open("#{Rails.root}/public/#{@file}") do |file|
      file.each_with_index do |line, i|
        next if i == 0
        column = line.split(',')
        post = Post.new
        post.title = column[0]
        post.content = column[1]
        post.user_id = @user
        response = true if post.save!
        response
      end
    end
  end

  # def validate_extension
  #   allow_extensions = ['.txt']
  #   true if allow_extensions.include? File.extname(@file.original_filename)
  # end
end