require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"
end

get '/about' do
	erb :about
end
get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts
end

post '/visit' do
	@name = params[:name]
  @email = params[:email]
  @phone = params[:phone]
	@barber = params[:barber]
	@color = params[:color]


	hh = {:name => 'Enter name',
				:email => 'Enter you mail address',
				:phone => 'Enter your phone'}
						#Для каждой пары ключ-значение
hh.each do |key, value|
						#И если параметр пуст
	if params[key] == ''
						#Переменной error присвоить значение value из хэша hh
						#То есть определенное сообщение об ощибке
		@error = hh[key]
						#Вернуть представление visit
		return erb :visit
	end
end
#@error = hh.select {|key, _| params[key] == ""}.values.join(", ") - еще один вариант записи пропаботки error
#if @error != ''
#	return erb :visit
#end

#	if @name == '' || @email == '' || @phone == '' # Мой вариант
#		@error = 'Please fill nessesary fields!'
#		return erb :visit
#	end

	f = File.open '.\public\users.txt', 'a'
  f.write "User: #{@name}, Email #{@email}, Phone: #{@phone}, Selected barber #{@barber}, Color #{@color}"
  f.close
	erb :visit
end

post '/contacts' do
  @email = params[:email]
  @message = params[:message]

	c = File.open '.\public\contacts.txt', 'a'
  c.write "Email #{@email}, Message: #{@message}"
  c.close
	erb :contacts
end
