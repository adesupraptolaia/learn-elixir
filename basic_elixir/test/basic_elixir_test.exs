defmodule BasicElixirTest do
  use ExUnit.Case
  doctest BasicElixir

  test "greets the world" do
    assert BasicElixir.hello() == :world
  end

  test "basic data type" do
    number = 100
    string = "hello"
    boolean = true
    float = 2.5
    atom = :this_is_an_atom

    assert number == 100
    assert string == "hello"
    assert boolean == true
    assert float == 2.5
    assert atom == :this_is_an_atom
  end

  test "boolean is atom" do
    assert true == true
    assert is_atom(true)
    assert is_boolean(true)
  end

  test "module name is atom" do
    assert is_atom(BasicElixir)
    assert BasicElixir === :"Elixir.BasicElixir"
  end

  test "arithmetic operations" do
    assert 1 + 1 === 2
    assert 10 - 7 === 3
    assert 2 * 4 === 8
    # result is float
    assert 10 / 2 === 5.0
    # result is integer
    assert div(10, 2) === 5
    # modulo
    assert rem(13, 5) === 3
  end

  test "operator ||, &&, and !" do
    # accept all data types
    # || ===> get the first the truthy value
    # && ===> get the first the falsy value
    assert (true || 42) === true
    assert (true && 42) === 42

    assert (42 || true) === 42
    assert (42 && true) === true

    assert (false || 42) === 42
    assert (false && 42) === false

    assert (42 || false) === 42
    assert (42 && false) === false

    assert (false || nil) === nil
    assert (false && nil) === false

    assert (1 || 2 || 3) === 1
    assert (1 && 2 && 3) === 3

    assert (1 || false || 3) === 1
    assert (1 && false && 3) === false

    assert (false || 1 || nil) === 1
    assert (false && 1 && nil) === false

    assert !true === false
    assert !false === true
  end

  test "operator \"and\" and \"or\"" do
    # first argument must be boolean (true or false)

    assert (true and true) === true
    assert (true and false) === false
    assert (false and true) === false
    assert (false and false) === false

    assert (true or true) === true
    assert (true or false) === true
    assert (false or true) === true
    assert (false or false) === false

    assert (true and 42) === 42
    assert (true or 42) === true
    assert (false and 42) === false
    assert (false or 42) === 42

    try do
      42 and true
    rescue
      e -> IO.inspect(e)
    end
  end

  test "comparison operators" do
    assert 1 == 1 == true
    assert 1 != 2 == true
    assert 1 < 2 == true
    assert 2 <= 2 == true
    assert 5 > 2 == true
    assert 2 >= 2 == true

    # strict comparison
    assert 1 === 1.0 == false
    assert 1 == 1.0 == true

    # all data type in elixir can be compared
    # number < atom < reference < function < port < pid < tuple < map < list < bitstring
    # assert :ok > 10_000 === true
    # assert [1, 2, 3] > {:hello, :world} === true
  end

  test "string interpolation" do
    name = "Elixir"
    assert "Hello #{name}" === "Hello Elixir"
    assert "Hello #{1 + 1}" === "Hello 2"

    assert "Hello " <> name === "Hello Elixir"
  end
end
