defmodule Sec13FFilingParser do
  @moduledoc """
  Documentation for Sec13FFilingParser.
  """

  def parse(txt) do
    {:ok, Sec13FFilingParser.Filing.parse(txt)}
  catch
    :exit, _ -> {:error, "text file could not be processed"}
  end

  def parse!(txt) do
    case parse(txt) do
      {:ok, filing} -> filing
      {:error, error} -> raise error
    end
  end
end
