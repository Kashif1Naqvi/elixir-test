defmodule PasswordGenerator do
  @moduledoc """
  Generate random password depnding on parameters, Module Main function is `generate(options)`
  This function takes the options map

  ##Options Example:
    options = %{
      "length" => "5",
      "numbers" => "false",
      "upercase" => "false",
      "symbols" => "false"
    }
  the options are only 4, length, numbers, upercase, symbols
  """
  @allowed_options  [:length, :numbers, :uppercase, :symbols]

  @doc """
  Generates password for given options:

  ## Examples

    options = %{
      "length" => "5",
      "numbers" => "false",
      "upercase" => "false",
      "symbols" => "false"
    }
      iex> PasswordGenerator.generate(options)
      "abcdf"

    options = %{
      "length" => "5",
      "numbers" => "true",
      "upercase" => "false",
      "symbols" => "false"
    }
      iex> PasswordGenerator.generate(options)
      "abcd3"


  """

  @spec generate(options :: map()) :: {:ok, bitstring()} | {:error, bitstring()}
  def generate(options) do
    length = Map.has_key?(options, "length")
    validate_length(length, options)
  end

  defp validate_length(false, _options), do: {:error, "Please Provide a length"}

  defp validate_length(true, options) do
    number = Enum.map(0..9, & Integer.to_string(&1))
    length =  options["length"]
    length =  String.contains?(length, number)
    validate_length_is_integer(length, options)

  end

  defp validate_length_is_integer(false, _options) do
    {:error, "Only integer allowed for length."}
  end

  defp validate_length_is_integer(true, options) do
    length = options["length"] |> String.trim() |> String.to_integer()
    options_without_length = Map.delete(options, "length")
    options_values = Map.values(options_without_length)
    value =
      options_values
      |> Enum.all?(fn x -> String.to_atom(x) |> is_boolean() end)
    validate_options_values_are_boolean(value, length, options_without_length)
  end

  defp validate_options_values_are_boolean(false, _length, _options) do
    {:error, "Only Booleans allowed for options values"}
  end
  defp validate_options_values_are_boolean(true, length, options) do
    options = included_options(options)
    invalid_options? = options |> Enum.any?(&(&1 not in @allowed_options))
    validate_options(invalid_options?, length, options)
  end

  defp validate_options(true, _length, _options) do
    {:error, "Only options allowed numbers, uppercase, symbols."}
  end

  defp validate_options(false, length, options) do
    generate_string(length, options)
  end

  defp generate_string(length, options) do
    options = [:lowercase_letter | options ]
    included = include(options)
    length = length - length(included)
    random_string = generate_random_string(length, options)
    strings = included ++ random_string
    get_result(strings)
  end

  defp get_result(strings) do
    string =
      strings
        |> Enum.shuffle()
        |> to_string()
    {:ok, string}
  end

  defp include(options) do
    options
    |> Enum.map(&get(&1))
  end

  defp get(:lowercase_letter) do
    <<Enum.random(?a..?z)>>
  end

  defp get(:uppercase) do
    <<Enum.random(?A..?Z)>>
  end

  defp get(:numbers) do
    Enum.random(?0..?9)
    |> Integer.to_string()
  end

  @symbols "!#$%&()*+-./:;<=>?@[]^_{|}~"
  defp get(:symbols) do
    symbols =
      @symbols
        |> String.split("", trime: true)

    Enum.random(symbols)

  end


  defp generate_random_string(length, options) do
    Enum.map(1..length, fn _ ->
      Enum.random(options) |> get()
    end)
  end


  defp included_options(options) do
    Enum.filter(options, fn {_key, value}->
      value |> String.trim() |> String.to_existing_atom()
    end)
    |> Enum.map(fn {key, _value} -> String.to_atom(key) end)
  end

end
