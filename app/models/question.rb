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

class Question < ActiveRecord::Base

  has_many :answers
  
  def opinions_given
    opinions = {}
    opinions.default = 0
    
    self.answers.each do |answer|
      opinions[answer.content] += 1 if answer.content
    end
    
    opinions
  end
  
  def most_supported_answer
    most_popular_opinion = opinions_given.max { |o1, o2| o1[occurrence = 1] <=> o2[occurrence = 1] }
    most_popular_opinion ? most_popular_opinion[answer_content = 0] : I18n.t('models.question.no_answer_so_far')
  end

  def add_or_substitute answer
    answerer = answer.supporter
    previous_answers = answers.select { |a| a.supporter == answerer }
    previous_answers.map &:destroy
    answers << answer
  end
end
