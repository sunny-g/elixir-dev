defmodule Math do

  defmacro add_to(arg1, arg2 \\ 0) do
    quote do
      unquote(arg1) + unquote(arg2)
    end
  end
end
