# frozen_string_literal: true

require 'active_record'

def db_configuration
  db_config =
    File.join(File.expand_path(__dir__), '..', 'db', 'config.yml')
  YAML.load(File.read(db_config))
end

ActiveRecord::Base.establish_connection(db_configuration['development'])
