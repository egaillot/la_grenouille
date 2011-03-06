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

class QuestionsControllerTest < ActionController::TestCase

  should_act_as_authenticated_controller

  def setup 
    activate_authlogic
    log_in
  end

  def test_should_render_index
    @question = Factory :question

    get :index
    assert_response :success
    assert_equal [@question], assigns(:questions)
  end
  
  def test_should_redirect_to_login_if_attempting_to_access_questions_unlogged
    log_out
    get :index
    assert_redirected_to new_user_session_path
    assert_equal 'Vous devez être authentifié pour accéder à cette fonctionnalité.', flash[:error]
  end
  
  def test_should_render_new
    get :new
    assert_response :success
    assert assigns(:question)
  end
  
  def test_should_render_create
    assert_difference 'Question.count', 1 do
      post :create, :question => {:content => "Where to?"}
    end
    
    assert_redirected_to questions_path
  end
end
