defmodule BasicEnumTest do
  use ExUnit.Case

  # enum is module in elixir for working with enumerable
  # all collection data type in elixir is enumerable, except tuple

  test "enum.all?" do
    # it will return true if all element in enumerable is truthy

    assert Enum.all?([1, 2, 3], fn x ->
             x > 0
           end) === true

    assert Enum.all?([1, 2, 3], fn x ->
             rem(x, 2) === 0
           end) === false
  end

  test "enum.any?" do
    # it will return true if at least one element in enumerable is truthy

    assert Enum.any?([1, 2, 3], fn x ->
             x > 0
           end) === true

    assert Enum.any?([1, 2, 3], fn x ->
             rem(x, 2) === 0
           end) === true

    assert Enum.any?([1, 2, 3], fn x ->
             x < 1
           end) === false
  end

  test "enum" do
    # Enum.each
    # iterate over each element, but not provide return value

    assert Enum.each([1, 2, 3], fn x ->
             # print 1 \n 2 \n 3
             IO.puts(x)
           end) === :ok

    # Enum.map
    # iterate over each element, and return new element
    assert Enum.map([1, 2, 3], fn x ->
             x * 2
           end) === [2, 4, 6]

    # Enum.reduce
    # iterate over each element, and return single value
    assert Enum.reduce([1, 2, 3], 0, fn x, acc ->
             x + acc
           end) === 6

    # Enum.min, Enum.max
    assert Enum.min([1, 2, 3]) === 1
    assert Enum.max([1, 2, 3]) === 3

    # Enum.filter
    assert Enum.filter([1, 2, 3, 4, 5, 6, 7], fn x ->
             rem(x, 2) === 0
           end) === [2, 4, 6]

    assert Enum.filter([1, 2, 3, 4, 5, 6, 7], fn num -> ModuleTest.is_even(num) end) === [2, 4, 6]
    assert Enum.filter([1, 2, 3, 4, 5, 6, 7], &ModuleTest.is_even/1) === [2, 4, 6]
    assert Enum.filter([1, 2, 3, 4, 5, 6, 7], &ModuleTest.is_even(&1)) === [2, 4, 6]
  end
end

defmodule ModuleTest do
  def is_even(num) do
    rem(num, 2) === 0
  end
end
