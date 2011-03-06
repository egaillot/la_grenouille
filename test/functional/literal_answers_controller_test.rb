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

class LiteralAnswersControllerTest < ActionController::TestCase

  should_act_as_authenticated_controller

  attr_reader :current_user, :question

  def setup
    activate_authlogic
    @current_user = log_in
    @question = Factory :question
  end

  def test_should_assign_question_when_rendering_index
    get :index, :question_id => question.to_param

    assert_response :success
    assert_equal question, assigns(:question)
  end
  
  def test_should_count_answers_occurence_when_rendering_index
    answers = question.answers
    assert_equal 1, answers.size
    answer = answers.first
    Factory :literal_answer, :content => answer.content, :question_id => question.to_param
    
    get :index, :question_id => question.to_param
    
    expected_result = {answer.content => 2}
    assert_equal expected_result, assigns(:answers)
  end
  
  def test_should_be_able_to_create_new_answers
    assert_difference 'question.reload.answers.size' do
      post :create, :question_id => question.to_param, :literal_answer => {:content => 'Blah'}
    end
    assert_redirected_to question_literal_answers_path(question)

    answer = LiteralAnswer.find_by_content 'Blah'
    assert_equal current_user, answer.supporter
  end
  
  def test_a_user_should_be_able_to_support_only_one_answer_at_a_time
    post :create, :question_id => question.to_param, :literal_answer => {:content => 'Blah'}
    assert_no_difference 'question.reload.answers.size' do
      post :create, :question_id => question.to_param, :literal_answer => {:content => 'Whizz'}
    end

    assert_equal nil, LiteralAnswer.find_by_content('Blah')
  end
end
