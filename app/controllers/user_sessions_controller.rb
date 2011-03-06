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

class UserSessionsController < ApplicationController

  def new
    redirect_to questions_path if current_user
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new params[:user_session]
    if @user_session.save
      redirect_to questions_path
    else
      render :new
    end
  end
  
  def destroy
    UserSession.find.destroy
    redirect_to new_user_session_path
  end
end
