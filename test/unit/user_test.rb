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

class UserTest < ActiveSupport::TestCase

  def test_should_be_able_to_sort_and_return_all_users_but_any_given_one
    manu, salome, riffraff = ['manu', 'salome', 'riffraff'].map { |login| User.new :login => login }
    User.stubs :all => [manu, salome, riffraff]
    assert_equal [riffraff, salome], User.all_but(manu)
  end
end
