defmodule PatternMatchingTest do
  use ExUnit.Case

  # pattern matching
  # in elixir, operator = is pattern matching, not only assigment
  # it will match the pattern on the left with the pattern on the right
  # if the pattern on the left matches the pattern on the right
  # if there is a variable on the left expression, then the variable will be bound to the value on the right

  test "pattern matching" do
    a = 1
    assert a === 1

    {a, b} = {1, 2}
    assert a === 1
    assert b === 2

    # it cause error
    try do
      1 = b
    rescue
      e -> IO.inspect(e)
    end

    # it not cause error
    # 1 = a

    {1, 2, c, 4} = {1, 2, 3, 4}
    assert c === 3

    [1 | tail] = [1, 2, 3]
    assert tail === [2, 3]
  end

  test "pin operator" do
    # ^ is pin operator
    # it will not bind variable
    # we only want to match the pattern with existing value

    a = 1
    ^a = 1

    # it cause error
    try do
      # it will not bind variable
      # ^a = 2 means 1 = 2, it cause error
      ^a = 2
    rescue
      # %MatchError{term: 2}
      e -> IO.inspect(e)
    end

    {a, ^a} = {5, 1}
    assert a === 5

    greeting = "hello"

    greet = fn
      ^greeting, name -> "Hi #{name}"
      greeting, name -> "#{greeting}, #{name}"
    end

    assert greet.("hello", "budi") === "Hi budi"
    assert greet.(greeting, "bambang") === "Hi bambang"
    assert greet.("halo", "bang") === "halo, bang"
    assert greet.("morning", "mister") === "morning, mister"
  end
end
