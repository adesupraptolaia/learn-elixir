defmodule BasicCollectionTest do
  use ExUnit.Case

  test "list" do
    # implementation list in elixir is linked list
    # if you add element to the "head", it is O(1)
    # but if you add element to the "tail", it is O(n)
    # so, if you want get the length of the list, it is O(n)

    assert [1, 2, 3] === [1, 2, 3]

    list = [2, 3, 4, 5]

    # fast, it will share memory with old list
    assert [1 | list] === [1, 2, 3, 4, 5]
    assert [1] ++ list === [1, 2, 3, 4, 5]

    # slow, it should be create new list in memory
    assert list ++ [6] === [2, 3, 4, 5, 6]
  end

  test "list substraction" do
    assert [1, 2, 3] -- [1] === [2, 3]
    assert [1, 2, 3] -- [1, 2] === [3]
    assert [1, 2, 3] -- [1, 2, 3] === []
    assert [1, 2, 3] -- [4, 5, 6] === [1, 2, 3]

    # will delete fist element that match
    assert [1, 2, 2, 3, 3, 3] -- [2] === [1, 2, 3, 3, 3]
    assert [1, 2, 2, 3, 3, 3] -- [2, 2, 3] === [1, 3, 3]

    # not cause error for not exist element
    assert [1, 2, 3] -- [4, 5, 6] === [1, 2, 3]

    # strict comparison, number and float is not equal
    assert [1, 2, 3] -- [1.0] === [1, 2, 3]
  end

  test "head and tail" do
    list = [1, 2, 3, 4, 5]

    [head | tail] = list
    assert head === 1
    assert tail === [2, 3, 4, 5]

    # get first element, use hd
    assert hd(list) === 1
    assert hd([1]) === 1

    # get remaining elements (still list), use tl
    assert tl(list) === [2, 3, 4, 5]
    assert tl([1]) === []
  end

  test "tuple" do
    # tuple is similar to list, but fixed length
    # tuple are stored contiguously in memory, so you can access tuple element by index
    # when you change tuple, it will create new tuple in memory
    # if you want access tuple length, it is O(1)

    tuple = {1, 2, 3}
    assert tuple === {1, 2, 3}

    # access tuple element
    assert elem(tuple, 0) === 1

    # access length of tuple
    assert tuple_size(tuple) === 3

    # change element of tuple
    assert put_elem(tuple, 0, :ok) === {:ok, 2, 3}
  end

  test "keyword list" do
    # keyword list is a list of tuples, it's associative collection
    # where the first element of each tuple is an atom and the second element is the value
    # key in keyword list must be atom, and can be duplicate

    # note
    # peformance of keyword list same with list
    # not recommend to use keyword list if size of keyword list is too big, it will traverse all element

    keyword_list = [{:a, 1}, {:b, 2}, {:c, 3}]
    keyword_list_other = [a: 1, b: 2, c: 3]

    assert keyword_list === keyword_list_other

    # access keyword list element
    assert Keyword.get(keyword_list, :a) === 1

    # access length of keyword list
    assert length(keyword_list) === 3

    # change keyword list element
    assert Keyword.put(keyword_list, :a, :ok) === [{:a, :ok}, {:b, 2}, {:c, 3}]

    # delete keyword list element
    assert Keyword.delete(keyword_list_other, :a) === [{:b, 2}, {:c, 3}]

    # duplicate keyword list element
    duplicate_keyword_list = keyword_list ++ [{:a, "a"}, {:b, "b"}, {:c, "c"}]
    assert duplicate_keyword_list === [{:a, 1}, {:b, 2}, {:c, 3}, {:a, "a"}, {:b, "b"}, {:c, "c"}]

    ## get duplicate keyword list, it will return first element
    assert Keyword.get(duplicate_keyword_list, :a) === 1

    ## get all duplicate keyword list, it will return list
    assert Keyword.get_values(duplicate_keyword_list, :a) === [1, "a"]
  end

  test "map" do
    # map is a collection of key-value pairs
    # map are stored in hash table, so you can access map element by key
    # when you change map, it will create new map in memory, and share reference to old map
    # if you want access map length, it is O(1)

    # a, b, and c is atom
    map = %{"name" => "ade", 100 => :ok, :a => 1, b: 2, c: 3}

    # access map size/length
    assert Kernel.map_size(map) === 5

    # access map element
    # only applicable when key is atom, it cause error when key is not exist
    assert map.a === 1
    assert map["name"] === "ade"
    assert map[:b] == 2
    # safe access
    assert map["not found"] === nil

    # change map element
    map = Map.put(map, "name", "budi")
    assert map["name"] === "budi"

    # other way to change map element
    # but it cause error if key is not exist
    map = %{map | "name" => "ade"}
    assert map["name"] === "ade"

    # add new key-value to map
    map = Map.put(map, "address", "riau")
    assert map["address"] === "riau"

    # delete map element
    map = Map.delete(map, "address")
    assert map["address"] === nil

    # you can use variable as key of map
    key = "age"
    map = Map.put(map, key, 20)
    assert map[key] === 20
    assert map["age"] === 20
  end
end
