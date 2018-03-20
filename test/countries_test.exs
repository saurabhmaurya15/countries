defmodule CountriesTest do
  use ExUnit.Case
  doctest Countries

  test "greets the world" do
    assert Countries.hello() == :world
  end
end
