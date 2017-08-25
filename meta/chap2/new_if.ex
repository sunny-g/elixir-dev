defmodule ControlFlow do

  # same as the native `if`
  defmacro my_if(expr, do: block), do: ControlFlow.my_if(expr, do: block, else: nil)
  defmacro my_if(expr, do: if_block, else: else_block) do
    quote do
      case unquote(expr) do
        result when result in [false, nil] -> unquote(else_block)
        _ -> unquote(if_block)
      end
    end
  end

  # a `while` loop
  @doc """
    ## Example
    iex> while true do
      IO.puts("something")
      break
    end
  """
  defmacro while(expr, do: block) do
    quote do
      try do
        for _ <- Stream.cycle([:ok]) do
          if unquote(expr) do
            unquote(block)
          else
            ControlFlow.break
          end
        end
      catch
        :break -> :ok
      end
    end
  end

  def break, do: throw :break
end
