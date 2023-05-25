require 'import_txt'

class ImportJob
  include Sidekiq::Job
  sidekiq_options retry: false

  def perform(arquivo, user)
    import_file = ImportTxt.new(arquivo, user)
    import_file.call
  end
end
