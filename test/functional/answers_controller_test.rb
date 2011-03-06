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

require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  
  should_act_as_authenticated_controller
  
  def setup
    activate_authlogic
    log_in
  end
  
  def test_should_render_new
    other_user = Factory :user
    question = Factory :question, :answers => []
    get :new, :question_id => question.to_param
    
    assert_response :success
    assert_equal question, assigns(:question)
    assert assigns(:answer)
    assert_equal [other_user], assigns(:trustees)
  end
end