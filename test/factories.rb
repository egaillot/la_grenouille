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

Factory.define :literal_answer do |literal_answer|
  literal_answer.content 'Yes, definitely.'
  literal_answer.supporter { |supporter| supporter.association :user  }
end

Factory.define :question do |question|
  question.content 'To be or not to be?'
  question.answers { |answers| [answers.association :literal_answer] }
end

Factory.sequence :login do |n|
  "login#{n}"
end

Factory.define :user do |user|
  user.login { Factory.next :login }
  user.password 'quire69'
  user.password_confirmation 'quire69'  
end