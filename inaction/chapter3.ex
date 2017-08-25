defmodule Chapter3 do

  @doc """
  take a file path, returns a list of numbers representing the length of the line from the file
  """
  def lines_length!(path) do
    File.stream!(path)
    |> Stream.map(fn(line) -> String.length(line) end)
    |> Enum.to_list
  end

  @doc """
  take a file path, returns length of longest line in the file
  """
  def longest_line_length!(path) do
    File.stream!(path)
    |> Stream.map(fn(line) -> String.length(line) end)
    |> Enum.reduce(0, fn(max, len) ->
      if (max > len) do
        max
      else
        len
      end
    end)
  end

  @doc """
  take a file path, returns contents of the longest line of the file
  """
  def longest_line!(path) do
    File.stream!(path)
    |> Enum.reduce("", fn(line1, line2) ->
      if (String.length(line1) > String.length(line2)), do: line1, else: line2
    end)
  end

  @doc """
  take a file path, returns list of numbers, each number representing the word count of the line
  """
  def words_per_line!(path) do
    File.stream!(path)
    |> Enum.map(fn(line) ->
      line
      |> String.split(" ")
      |> length
    end)
  end
end
