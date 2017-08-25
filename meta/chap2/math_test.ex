defmodule Math.Test do
  use Assertion

  test "integers should be equal to eachother" do
    assert 1 == 1
    assert 2 == 3
  end
end