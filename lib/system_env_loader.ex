defmodule SystemEnvLoader do
  def load(file) do
    {:ok, content} = File.read(file)
    parsed         = content |> parse_content
    System.put_env(parsed)
    {:ok, parsed}
  end

  def parse_content(content) do
    content
      |> String.split("\n")
      |> Enum.filter(fn(x)->  String.starts_with?(x, "export") && String.contains?(x, "=") end)
      |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    [k,v] = line |> String.split("export") |> Enum.at(-1) |> String.split("=") |> Enum.map(&String.strip/1)
    { k, unwrap_brackets(v) }
  end

  defp unwrap_brackets(s) do
    list   = s |> String.to_char_list
    length = list |> Enum.count
    cond do
      list |> Enum.at(0) == ?" && list|> Enum.at(-1) == ?"  -> Enum.slice(list, 1, length - 2) |> List.to_string
      list |> Enum.at(0) == ?' && list|> Enum.at(-1) == ?'  -> Enum.slice(list, 1, length - 2) |> List.to_string
      true                                                  -> s
    end
  end
end
