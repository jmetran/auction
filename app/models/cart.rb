class Cart
  def paypal_url(return_url)
    values = {
      :business => 'seller_1316488112_biz@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url,
      :invoice => 1
    }
    #line_items.each_with_index do |item, index|
      values.merge!({
        "amount_1" => "10",
        "item_name_1" => "Bid",
        "item_number_1" => "4",
        "quantity_1" => "4"
      })
    #end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
end
