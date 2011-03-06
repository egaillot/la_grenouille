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

class QuestionTest < ActiveSupport::TestCase

  should have_many :answers

  attr_reader :question

  def setup
    @question = Question.new
  end
  
  
  def test_should_know_opinions_given
    answers = ['a', 'b', 'a'].map { |c| LiteralAnswer.new :content => c }
    question.stubs :answers => answers
    expected_result = {'a' => 2, 'b' => 1}
    assert_equal expected_result, question.opinions_given
  end

  def test_should_discard_opinions_not_given_yet
    delegated_answer = Answer.new :content => nil
    answers = [delegated_answer]
    question.stubs :answers => answers
    expected_result = {}
    assert_equal expected_result, question.opinions_given
  end
  
  def test_should_know_most_supported_answer
    question.stubs :opinions_given => {'a' => 23, 'b' => 37, 'c' => 2}
    assert_equal 'b', question.most_supported_answer
  end
  
  def test_should_say_something_interesting_even_if_question_is_not_answered_yet
    question.stubs :opinions_given => {}
    assert_equal "Pas de réponse pour l'instant", question.most_supported_answer
  end
  
  def test_should_add_answer_if_user_has_not_already_answered
    user = stub 'user'

    answer = LiteralAnswer.new :content => 'Whizz'
    answer.stubs :supporter => user
    answer_by_someone_else = LiteralAnswer.new :content => 'Blah'
    answer_by_someone_else.stubs :supporter => stub

    answers = [answer_by_someone_else]
    question.stubs :answers => answers

    answer_by_someone_else.expects(:destroy).never
    answers.expects(:<<).with(answer)
    question.add_or_substitute answer
  end

  def test_should_replace_answer_if_user_has_already_answered
    user = stub 'user'

    answer = LiteralAnswer.new :content => 'Whizz'
    answer.stubs :supporter => user
    previous_answer = LiteralAnswer.new :content => 'Blah'
    previous_answer.stubs :supporter => user

    answers = [previous_answer]
    question.stubs :answers => answers

    previous_answer.expects(:destroy)
    answers.expects(:<<).with(answer)
    question.add_or_substitute answer
  end
end
