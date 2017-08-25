defmodule Assertion do

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)
      Module.register_attribute __MODULE__, :tests, accumulate: true
      @before_compile unquote(__MODULE__)
    end
  end

  defmacro __before_compile__(_) do
    quote do
      def run, do: Assertion.Test.run(@tests, __MODULE__)
    end
  end

  defmacro test(description, do: test_block) do
    test_name = String.to_atom(description)
    quote do
      @tests {unquote(test_name), unquote(description)}

      def unquote(test_name)(), do: unquote(test_block)
    end
  end

  # {operator, env, [actual, expected]}
  defmacro assert({operator, _, [actual, expected]}) do
    quote bind_quoted: [
      operator: operator,
      actual: actual,
      expected: expected
    ] do
      Assertion.Test.test(operator, actual, expected)
    end
  end
end

defmodule Assertion.Test do
  def run(tests, module) do
    Enum.each(tests, fn {name, description} ->
      case apply(module, name, []) do
        :ok             -> IO.write "."
        {:fail, reason} -> IO.puts """
          FAILURE: #{description}
            #{reason}
        """
      end
    end)
  end

  def test(:==, actual, expected) when actual == expected, do: :ok
  def test(:==, actual, expected) do
    {:fail, """
      Expected:     #{expected}
      Actual:       #{actual}
    """}
  end
end
