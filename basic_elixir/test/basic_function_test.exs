defmodule BasicFunctionTest do
  use ExUnit.Case

  test "anonymous function" do
    add = fn x, y -> x + y end

    assert add.(1, 2) === 3
    assert add.(4, 5) === 9

    # shorthand using & operator
    # it same with subtract = fn x, y -> x - y end
    subtract = &(&1 - &2)

    assert subtract.(3, 10) === -7
    assert subtract.(10, 4) === 6
  end

  test "function with pattern matching" do
    handle = fn
      {:ok, data} -> "result ok: #{data}"
      {:error, reason} -> "result error: #{reason}"
      _ -> "result unknown"
    end

    assert handle.({:ok, "hello"}) === "result ok: hello"
    assert handle.({:error, "error"}) === "result error: error"
    assert handle.(:unknown) === "result unknown"
  end

  test "named function" do
    # we need to create the function inside module

    defmodule Math do
      def sum(a, b) do
        a + b
      end

      def multiply(a, b) when a === 0 or b === 0 do
        0
      end

      def multiply(a, b) when a < 0 do
        -1 * multiply(-a, b)
      end

      def multiply(a, b) when b < 0 do
        -1 * multiply(a, -b)
      end

      def multiply(a, b) do
        Enum.reduce(1..a, 0, fn x, acc ->
          sum(acc, b)
        end)
      end
    end

    assert Math.sum(1, 2) === 3
    assert Math.sum(-1, -2) === -3
    assert Math.sum(1, -2) === -1
    assert Math.multiply(10, 4) === 40
    assert Math.multiply(-10, -4) === 40
    assert Math.multiply(-10, 4) === -40
    assert Math.multiply(10, -4) === -40
    assert Math.multiply(-10, 0) === 0
    assert Math.multiply(0, 10) === 0
  end
end
