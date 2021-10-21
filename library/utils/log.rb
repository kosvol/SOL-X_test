# frozen_string_literal: true

require 'logger'
require 'singleton'

class Log
  include Singleton

  def initialize
    @logger = Logger.new($stdout)
  end

  def info(message)
    @logger.info(message)
  end

  def debug(message)
    @logger.debug(message)
  end

  private

  def console(message)
    puts message
  end
end
