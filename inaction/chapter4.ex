defmodule Chapter4 do

end

defmodule Fraction do
  defstruct numerator: nil, denominator: nil

  @doc """

  """
  def new(numerator, denominator) when is_integer(numerator) and is_integer(denominator) do
    %Fraction{ numerator: numerator, denominator: denominator }
  end

  def decimal_value(%Fraction{ numerator: numerator, denominator: denominator }) do
    numerator / denominator
  end

  def add(
    %Fraction{ numerator: num1, denominator: den1 },
    %Fraction{ numerator: num2, denominator: den2 }
  ) do
    new( (num1 * den2) + (num2 * den1), den1 * den2 )
  end
end
