# frozen_string_literal: true

require_relative '../../utils/time_service'
require_relative '../../utils/env_utils'
require_relative '../../utils/user_service'
# base api request class across sections
class BaseSectionApi
  include EnvUtils

  def initialize
    @user_service = UserService.new
    @time_service = TimeService.new
  end
end
