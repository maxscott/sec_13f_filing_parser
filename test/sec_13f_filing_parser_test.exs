defmodule Sec13FFilingParserTest do
  use ExUnit.Case

  test "Parses example 13f for header and positions" do
    {:ok, txt} = File.read("test/fixtures/13f_example.txt")
    {:ok, filing} = Sec13FFilingParser.parse(txt)
    assert filing.header
    assert filing.positions
  end
end
