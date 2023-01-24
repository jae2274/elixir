defmodule MyEnum do
  def all?([],_func) do
    true
  end
  def all?([head|tail], func) when is_function(func) do
    if(func.(head)) do
      all?(tail, func)
    else
      false
    end
  end

  def each([], func) when is_function(func) do
    :ok
  end
  def each([head|tail], func) when is_function(func) do
    func.(head)
    each(tail,func)
    :ok
  end

  def filter([],_func) when is_function(_func) do
    []
  end
  def filter([head|tail], func) when is_function(func) do
    if(func.(head)) do
      [head|filter(tail, func)]
    else
      filter(tail, func)
    end
  end

  def split([], count) when is_integer(count) do
    {[],[]}
  end
  def split([head|tail], count) when is_integer(count) do
    cond do
      count<0 ->
        listSize = length([head|tail])
        count = if listSize + count < 0 , do: 0, else: listSize + count
        split([head|tail], count)
      count>0 ->
        {list1,list2} = split(tail, count-1)
        {[head|list1],list2}
      true ->
        {[],[head|tail]}
    end
  end

  def take([], count) when is_integer(count) do
     []
  end
  def take([head|tail], count) when is_integer(count) do
    cond do
      count<0->
        listSize = length([head|tail])
        count = if listSize + count < 0 , do: 0, else: listSize + count
        {_, list2} = split([head|tail], count)
        list2
      count>0 ->
        list = take(tail, count-1)
        [head|list]
      true ->
        []
    end
  end

  def flatten([]) do
    []
  end

  def flatten([head|tail]) do
    flatten([head|tail], [])
    |> Enum.reverse
  end

  defp flatten([],list) do
    list
  end

  defp flatten([head|tail], list) do
    if(is_list(head)) do
      list = flatten(head,list)
      flatten(tail,list)
    else
      list = [head|list]
      flatten(tail,list)
    end
  end

  def sosu?(num) when 2<=num do
    Enum.all?(2..(ceil(:math.sqrt(num))), &(rem(num,&1)!=0 || &1==num))
  end

  def sosu_list(num) when 2<=num do
    for x <- 2..num, sosu?(x),  do: x
  end
end


true = MyEnum.all?([2, 4, 6], fn x -> rem(x, 2) == 0 end)
false = MyEnum.all?([2, 3, 4], fn x -> rem(x, 2) == 0 end)
true = MyEnum.all?([], fn _ -> nil end)

:ok = MyEnum.each(["some", "example"], fn x -> IO.puts(x) end)

[2] = MyEnum.filter([1, 2, 3], fn x -> rem(x, 2) == 0 end)

{[1,2],[3]} = MyEnum.split([1, 2, 3], 2)

{[1,2,3],[]} = MyEnum.split([1, 2, 3], 10)
{[],[1,2,3]} = MyEnum.split([1, 2, 3], 0)
{[1,2],[3]} = MyEnum.split([1, 2, 3], -1)
{[],[1,2,3]} = MyEnum.split([1, 2, 3], -5)

[1,2] = MyEnum.take([1, 2, 3], 2)
[1,2,3] = MyEnum.take([1, 2, 3], 10)
[] = MyEnum.take([1, 2, 3], 0)
[3] = MyEnum.take([1, 2, 3], -1)

[1,2,3,4,5,6] = MyEnum.flatten([1,[2,3,[4]],5,[[[6]]]])

# Enum.each(MyEnum.sosu(14),&(IO.puts(&1)))
IO.puts MyEnum.sosu?(2)

Enum.each(MyEnum.sosu_list(17), &(IO.puts &1))
