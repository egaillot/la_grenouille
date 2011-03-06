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

class UserSessionsControllerTest < ActionController::TestCase

  def setup 
    activate_authlogic
  end

  def test_sanity_check
    salome = Factory :user
    manu = Factory :user
    assert_current_user salome
  end
  
  def test_root_path
    assert_routing '/', :controller => 'user_sessions', :action => 'new'
  end

  def test_should_render_new_user_session_as_login_form
    get :new
    assert_response :success
    assert assigns(:user_session)
  end
  
  def test_should_redirect_if_attenmpting_to_log_while_already_logged_in
    log_in
    get :new
    assert_redirected_to questions_path
  end
  
  def test_should_be_able_to_create_user_session
    manu = log_in
    post :create, :user_session => {:login => manu.login, :password => 'quire69'}
    assert_current_user manu
    assert_redirected_to questions_path
  end
  
  def test_should_handle_errors_on_create
    manu = log_in
    post :create, :user_session => {:login => manu.login, :password => 'badPassword'}
    assert_template :new
  end
  
  def test_should_be_able_to_destroy_user_session_as_logout
    log_in
    delete :destroy
    assert_current_user nil
    assert_redirected_to new_user_session_path
  end
  
  private
  
  def assert_current_user user
    user_session = UserSession.find
    current_user = user_session && user_session.user
    assert_equal current_user, user
  end
end
