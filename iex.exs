# show erlang single quoted char lists as lists
# IEx.configure inspect: [char_lists: false]
defmodule Clipboard do
  # Shamelessly stolen from https://github.com/jayjun/clipboard

  def paste() do
    {res, _} = System.cmd("/usr/bin/pbpaste", [])
    res
  end

  def copy(val) do
    port = Port.open({:spawn_executable, "/usr/bin/pbcopy"}, [:binary, args: []])

    value =
      case val do
        val when is_binary(val) ->
          val

        val ->
          val
          |> Inspect.Algebra.to_doc(%Inspect.Opts{limit: :infinity})
          |> Inspect.Algebra.format(:infinity)
      end

    send(port, {self(), {:command, value}})
    send(port, {self(), :close})
    val
  end
end
