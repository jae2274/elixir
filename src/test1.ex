orders = [
  [id: 123, ship_to: :NC, net_amount: 100.00],
  [id: 124, ship_to: :OK, net_amount: 35.50],
  [id: 125, ship_to: :TX, net_amount: 24.00],
  [id: 126, ship_to: :TX, net_amount: 44.80],
  [id: 127, ship_to: :NC, net_amount: 25.00],
  [id: 128, ship_to: :MA, net_amount: 10.00],
  [id: 129, ship_to: :CA, net_amount: 102.00],
  [id: 130, ship_to: :NC, net_amount: 50.00],
]


tax_rates = [NC: 0.075, TX: 0.08]


defmodule TaxCal do
  def copy_orders(orders,tax_rates) do
    for order <- orders, do: copy_order(order,tax_rates)
  end
  def copy_order(order, tax_rates) do
    ship = order[:ship_to]

    if(Keyword.has_key?(tax_rates, ship)) do
      amount = order[:net_amount]
      order ++ [total_amount: amount + amount * tax_rates[ship]]
    else
      order
    end
  end
end

TaxCal.copy_orders(orders, tax_rates)
