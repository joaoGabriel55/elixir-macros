defmodule MyMacro do
  def is_fault_no_macro(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)

    case condition do
      val when val in [false, nil] ->
        else_clause

      _otherwise ->
        do_clause
    end
  end

  defmacro is_fault(condition, clauses) do
    do_clause = Keyword.get(clauses, :do, nil)
    else_clause = Keyword.get(clauses, :else, nil)

    quote do
      case unquote(condition) do
        val when val in [false, nil] -> unquote(else_clause)
        _otherwise -> unquote(do_clause)
      end
    end
  end

  defmacro unless_pigs_flies(condition, clauses) do
    unless_clause = Keyword.get(clauses, :do, nil)

    quote do
      case unquote(condition) do
        val when val in [true, nil] -> nil
        _otherwise -> unquote(unless_clause)
      end
    end
  end
end

defmodule Test do
  require MyMacro

  MyMacro.is_fault 1 == 2 do
    IO.puts("1 == 2")
  else
    IO.puts("1 != 2")
  end

  MyMacro.unless_pigs_flies 23 == 2 do
    IO.puts("unless_pigs_flies")
  end

  MyMacro.is_fault_no_macro(1 == 2, do: IO.puts("1 == 2"), else: IO.puts("1 != 2"))
end
