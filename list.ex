defmodule MyList do
  defmacro get_element_by_index() do
    positions = [:first, :second, :third, :fourth, :fifth]

    Enum.with_index(positions, fn position, index ->
      quote do
        def unquote(position)(list), do: Enum.at(list, unquote(index))
      end
    end)
  end

  defmacro get_element_by_index([:primeiro, :segundo, :terceiro] = positions) do
    Enum.with_index(positions, fn position, index ->
      quote do
        def unquote(position)(list), do: Enum.at(list, unquote(index))
      end
    end)
  end

  defmacro get_element_by_index([:quarto, :quinto] = positions) do
    Enum.with_index(positions, fn position, index ->
      quote do
        def unquote(position)(list), do: Enum.at(list, unquote(index))
      end
    end)
  end
end

defmodule Test do
  require MyList

  MyList.get_element_by_index()
  MyList.get_element_by_index([:primeiro, :segundo, :terceiro])
  MyList.get_element_by_index([:quarto, :quinto])
end
