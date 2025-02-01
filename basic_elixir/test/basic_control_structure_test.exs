defmodule BasicControlStructureTest do
  use ExUnit.Case

  test "if and unless" do
    a =
      if is_number(123) do
        1
      else
        2
      end

    assert a === 1

    b =
      unless is_number(123) do
        1
      else
        2
      end

    assert b === 2
  end

  test "case" do
    # case is pattern matching, it will match the first matching pattern

    a =
      case is_number(123) do
        true -> 1
        false -> 2
      end

    assert a === 1

    # _ is wildcard
    # if there is no matching pattern, it will match _
    # if you not use _, it will cause error
    b =
      case is_number(123) do
        false -> 1
        _ -> 2
      end

    assert b === 2

    case {:ok, 7} do
      {:error, _} ->
        assert false

      {:ok, value} ->
        assert value === 7

      _ ->
        assert false
    end

    case :hello do
      :ok ->
        assert false

      :error ->
        assert false

      _ ->
        assert true
    end
  end

  test "cond" do
    # cond is pattern matching, it will match the first matching pattern

    cond do
      is_number("wrong") -> assert false
      is_atom(234) -> assert false
      is_bitstring(:ok) -> assert false
      1 + 1 === 2 -> assert true
    end

    # if there is no matching pattern, it will cause error
    cond do
      is_number("wrong") -> assert false
      is_atom(234) -> assert false
      is_bitstring(:ok) -> assert false
      true -> assert true
    end
  end

  test "with" do
    # with is pattern matching, it will pattern match the right side and left side

    user = %{
      name: "John Doe",
      age: 30
    }

    result =
      with {:ok, name} <- Map.fetch(user, :name),
           {:ok, age} <- Map.fetch(user, :age) do
        assert name === "John Doe"
        assert age === 30

        "Hello My name is #{name} and I am #{age} years old"
      end

    assert result === "Hello My name is John Doe and I am 30 years old"

    # if there is no matching pattern, it will cause error
    result =
      with {:ok, name} <- Map.fetch(user, :not_exist) do
        "result #{name}"
      end

    assert result === :error

    # you can handle the else condition
    result =
      with {:ok, name} <- Map.fetch(user, :not_exist) do
        "result #{name}"
      else
        # pattern matching
        :ok -> "ok"
        # default
        _ -> "error"
      end

    assert result === "error"
  end
end
