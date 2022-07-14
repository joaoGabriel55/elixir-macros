defmodule Times do
  defmacro times_n(number) do
    function_name = String.to_atom("times_#{number}")

    quote do
      def unquote(function_name)(value), do: unquote(number) * value
    end
  end
end

defmodule Test do
  require Times

  Times.times_n(3)
  Times.times_n(4)
end
