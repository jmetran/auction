require "rubygems"
require "active_merchant"

class CheckOutController < ApplicationController
  
  def index
    ActiveMerchant::Billing::Base.mode = :test

    gateway = ActiveMerchant::Billing::PaypalGateway.new(
      :login => "joshme_1316503791_biz_api1.gmail.com",
      :password => "1316503870",
      :signature => "AGMWMQr8juY42pCZSN9nHnbf0hvRACfF6L5secYqwJexYS3nt9Ww1Y.V"
    )

    credit_card = ActiveMerchant::Billing::CreditCard.new(
      :type               => "visa",
      :number             => "4129074636447164",
      :verification_value => "123",
      :month              => 9,
      :year               => 2016,
      :first_name         => "Joseph",
      :last_name          => "Metran"
    )

    

    if credit_card.valid?
      response = gateway.authorize(110000, credit_card, :ip => "127.0.0.1", :billing_address => {
      :name => 'Test User',
      :company => '',
      :address1 => '123 S Main St',
      :city => 'Akron',
      :state => 'OH',
      :country => 'US',
      :zip => '44333',
      :phone => '(310)555-5555'
    } )
      if response.success?
        gateway.capture(1000, response.authorization)
        puts "Purchase complete!"
      else
        puts "Error: #{response.message}"
      end
    else
      puts "Error: credit card is not valid. #{credit_card.errors.full_messages.join('. ')}"
    end
  end

end
