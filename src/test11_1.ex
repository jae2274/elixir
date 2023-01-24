defmodule StringUtils do
  def center(list) when is_list(list) do
    if(Enum.any?(list,&(!is_binary(&1)))) do
      raise "all element of list must be string"
    end

    max_length = Enum.max(list,&(String.length(&1)>String.length(&2)))
    |> String.length

    center(max_length,list)
  end

  defp center(_, []), do: []
  defp center(max_length, [word|tail]) when is_integer(max_length) do
    word_length = String.length(word)
    pad_count = ceil (max_length - word_length)/2 + word_length

    word_with_pad = word
    |> String.pad_trailing(pad_count)
    |> String.pad_leading(max_length)

    [word_with_pad|center(max_length, tail)]
  end

  def capi(string) when is_binary(string) do
    String.split(string, ". ")
    |>Enum.map(&(String.capitalize(&1)))
    |>Enum.join(". ")
  end

  # def parse_orders([head|tail]) do
  #   order = String.split(head,",")
  #   |>convert

  #   [order,parse_orders(tail)]
  #   # if(order), do: [order,parse_orders(tail)], else: parse_orders(tail)
  # end


end

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

  def parse_orders(path) when is_binary(path) do
    File.open!(path)
    |>IO.stream(:line)
    |>Stream.drop(1)
    |>Stream.map(&(String.trim(&1)))
    |>Stream.map(&(convert(&1)))
    |>Enum.to_list
  end

  def convert(line) when is_binary(line) do
    [id, ship_to, net_amount] = String.split(line,",")
    # Integer.parse(id)
    # Float.parse(net_amount)
    [
      id: String.to_integer(id),
      ship_to: String.to_atom(String.replace(ship_to,":","")),
      net_amount: String.to_float(net_amount)
    ]
  end
end
tax_rates = [NC: 0.075, TX: 0.08]
