require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "redcarpet"

configure do
  enable :sessions
  set :session_secret, 'secret'
end

before do
  session[:payments] ||= []
end

helpers do
  def hide_cc_number(cc_num)
    cc_num_str = cc_num.to_s
    split_cc = cc_num_str.chars.each_slice(4).map(&:join)
    hidden_cc = "****-****-****-#{split_cc[-1]}"
  end
end

def missing_data?(f_name, l_name, cc_num, exp_date, ccv_num)
  f_name_bool = f_name.to_s.empty?
  l_name_bool= l_name.to_s.empty?
  cc_num_bool = cc_num.to_s.empty?
  exp_date_bool = exp_date.to_s.empty?
  ccv_num_bool = ccv_num.to_s.empty?
  return {f_name => f_name_bool,
          l_name => l_name_bool,
          cc_num => cc_num_bool,
          exp_date => exp_date_bool,
          ccv_num => ccv_num_bool}
end

def valid_card?(card_num)
  if card_num.to_s.length == 16
    return true
  else
    return false
  end
end

get "/" do
 session.clear
end

get "/payments/create" do
  erb :payment
end

post "/payments/create" do
  @f_name = params[:f_name]
  @l_name = params[:l_name]
  @cc_num = params[:cc_number]
  @exp_date = params[:exp_date]
  @ccv_num = params[:ccv_num]

  input_hash_result = missing_data?(@f_name, @l_name, @cc_num, @exp_date, @ccv_num)
  @missing_data = []

  if params[:f_name].empty?
    @missing_data << "First Name"
  end
  if params[:l_name].empty?
    @missing_data << "Last Name"
  end
  if params[:cc_number].empty? || !valid_card?(@cc_num)
    @missing_data << "Credit Card Number"
  end
  if params[:exp_date].empty?
    @missing_data << "Expiration Date"
  end
  if params[:ccv_num].empty?
    @missing_data << "CCV Number"
  end

  if input_hash_result.each_value {|val| val == false} && valid_card?(@cc_num)
    @payment_time = Time.new
    session[:message] = "Thank you for your payment."
    session[:payments] << [@f_name, @l_name, @payment_time, @cc_num, @exp_date, @ccv_num]
    redirect "/payments"
  else
    missing_information = @missing_data.join(", ")
    session[:message] = "You are missing the following information: #{missing_information}"
    erb :payment
  end
end

get "/payments" do
  erb :payments_page
end
