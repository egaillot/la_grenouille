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

class DelegatedAnswerTest < ActiveSupport::TestCase
  
  should belong_to :trustee
  should validate_presence_of :trustee
  
  def test_should_know_its_content
    salome = User.new :login => 'salome'
    salome.stubs :id => 4807
    question = stub 'question', :id => 666
    final_answer = stub 'answer', :content => 'Blah'
    Answer.stubs(:find_by_question_id_and_supporter_id).with(question.id, salome.id).returns final_answer
    
    answer = DelegatedAnswer.new :trustee_id => salome.id, :question_id => question.id
    assert_equal 'Blah', answer.content
  end
  
  def test_should_handle_case_when_trustee_has_not_answered_yet
    salome = User.new :login => 'salome'
    salome.stubs :id => 4807
    question = stub 'question', :id => 666
    Answer.stubs(:find_by_question_id_and_supporter_id).with(question.id, salome.id).returns nil

    answer = DelegatedAnswer.new :trustee_id => salome.id, :question_id => question.id
    assert_equal nil, answer.content
  end
end