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

class DelegatedAnswersControllerTest < ActionController::TestCase

  should_act_as_authenticated_controller

  attr_reader :current_user
  
  def setup
    activate_authlogic
    @current_user = log_in
  end

  def test_should_be_able_to_create_new_delegated_answer
    question = Factory :question
    salome = Factory :user
    
    assert_difference ['DelegatedAnswer.count', 'question.reload.answers.size'] do
      post :create, :question_id => question.to_param, :delegated_answer => {:trustee_id => salome.to_param}
    end
    assert_redirected_to question_literal_answers_path(question)
    
    answer = DelegatedAnswer.last
    assert_equal current_user, answer.supporter
    assert_equal salome, answer.trustee
  end
end
