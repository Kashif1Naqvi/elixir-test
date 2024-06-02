I am very new to Elixer. I hope everyone appreciates me.
Versions
Erlang/OTP 26 [erts-14.2.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [jit:ns]

Elixir 1.15.7 (compiled with Erlang/OTP 26

Writing Test for Password Generator 
@doc """
  Generates password for given options:

  ## Examples

    options = %{
      "length" => "5",
      "numbers" => "false",
      "uppercase" => "false",
      "symbols" => "false"
    }
      iex> PasswordGenerator.generate(options)
      "abcdf"

    options = %{
      "length" => "5",
      "numbers" => "true",
      "uppercase" => "false",
      "symbols" => "false"
    }
      iex> PasswordGenerator.generate(options)
      "abcd3"


  """

  you can run the test just type the command

  ```mix test ```

You check my code

```lib/password_generator.ex```  
```test/password_generator_test.exs```
