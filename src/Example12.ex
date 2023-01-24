
defmodule FizzBuzz do
  def fizzWord(n) do
    case {rem(n,3),rem(n,5)} do
      {0,0} -> "FizzBuzz"
      {0,_} -> "Fizz"
      {_,0} -> "Buzz"
      {_,_} -> n
    end
  end
  def ok!({:ok, data}), do: data
  def ok!({:error,reason}), do: raise "Failed to open file:#{reason}"
  # def ok!({:enoent,reason}), do: raise "#{reason}"
end

# import FizzBuzz
# Enum.to_list(1..22) |> Enum.map(&FizzBuzz.fizzWord/1) |> Enum. |> Enum.each &IO.puts/1
