#    La Grenouille - A vote engine with a different flavor
#
#    Copyright (C) 2010 - 2011  Emmanuel Gaillot (emmanuel.gaillot@gmail.com)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require "authlogic/test_case"
require 'test_help'
require 'functional/acts_as_authenticated_controller_test'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
  fixtures :all
end

class ActionController::TestCase
  
  def self.should_act_as_authenticated_controller
    include ActsAsAuthenticatedControllerTest
  end
  
	def requires_user?
		before_filters = @controller.class.filter_chain.select{ |f| f.method == :require_user }
		! before_filters.empty?
	end
	
	def log_out
	  UserSession.find.destroy
  end
  
  def log_in
    Factory :user
  end
end