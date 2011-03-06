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

ActionController::Routing::Routes.draw do |map|

  map.root :controller => :user_sessions, :action => :new

  map.resources :questions, :only => [:index, :new, :create] do |questions|
    questions.resources :answers, :only => :new
    questions.resources :delegated_answers, :only => :create
    questions.resources :literal_answers, :only => [:index, :create]
  end
  
  map.resource :user_session, :only => [:new, :create, :destroy]
end
