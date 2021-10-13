# frozen_string_literal: true

require 'logger'
require 'singleton'

class Log < Logger
  include Singleton
  attr_reader :timestamp, :log_file_path

  def initialize
    if @start_new_log
      @timestamp = Time.now.strftime('%Y_%m_%d-%HH_%MM_%SS_%LS')
      @log_file_path = "#{Dir.getwd}/testreport/log/#{@scenario_name}_#{@timestamp}.log"
      super(@log_file_path)
      @formatter = Formatter.new
      @datetime_format = '%Y-%m-%d %H:%M:%S.%L '
    end
  end

  def start_new(scenario_name)
    @scenario_name = scenario_name
    @start_new_log = true
    initialize
    self
  end

  def info(message)
    if info?
      # Always log to console so info statements show up in cucumber report.
      # cucumber_world is injected into this object via the common hooks to give us access to cucumber world.
      @cucumber_world&.puts(message)
      message = format_log_message(message)
      super
    end
  end

  def debug(message)
    if debug?
      # console(message)
      message = format_log_message(message)
      super
    end
  end

  def warn(message)
    if warn?
      console(message)
      message = format_log_message(message)
      super
    end
  end

  def error(message)
    if error?
      console(message)
      message = format_log_message(message)
      super
    end
  end

  private

  def format_log_message(message)
    "#{message} [[#{caller[1].sub(%r{.*/}, '')}]]"
  end

  def log_directory
    @log_directory ||= Dir.getwd
  end

  def console(message)
    puts message
  end
end
