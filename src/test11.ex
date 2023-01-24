defmodule Chapter11 do
  def allAscii?([]) do
    true
  end
  def allAscii?([head|tail]) do
    32 <= head and head <=126 and allAscii?(tail)
  end

  def anagram?(word1, word2) when is_list(word1) and is_list(word2) do
    length(word1 -- word2) == 0 and length(word2 -- word1) == 0
  end

  def calculate([strings]) do
    elements = get_elements(strings)
    elements = cal_multi_divide(elements)
  end

  def get_elements(strings) do
    number(strings)
  end

  def cal_multi_divide(elements) do

  end
  def cal_multi_divide([value1, symbol1, value2, symbol2|tail]) when symbol in '*/' do
    case symbol1 do
      ?* -> cal_multi_divide([value1*value2,symbol2,cal_multi_divide(tail)])
      ?/ -> cal_multi_divide([value1/value2,symbol2,cal_multi_divide(tail)])
      _ -> [value1,symbol|cal_multi_divide([value2,symbol2|tail])]
    end


  end

  def cal_plus_minus(elements) do

  end

  def number([?-|tail]), do _number_digits(tail, 0) * -1
  def number([?+|tail]), do _number_digits(tail, 0)
  def number(str), do _number_digits(str, 0)

  defp _number_digits([], value) do
    [value]
  end
  defp _number_digits([digit|tail], value) when digit in '0123456789' do
    _number_digits(tail, value*10 + digit - ?0)
  end
  defp _number_digits([non_digit|tail], value) do
    [value, non_digit] ++ _number_digits(tail,0)
  end
end
