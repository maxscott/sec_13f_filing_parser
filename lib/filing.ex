defmodule Sec13FFilingParser.Filing do
  @moduledoc """
  Documentation for the Filing object, which contains positions
  """

  def parse(txt) do
    [_, header_xml, _, positions_xml, _] =
      txt
      |> String.replace("\n", "")
      |> String.split(["<XML>", "</XML>"])

    %{
      header: parse_header(header_xml),
      positions: parse_positions(positions_xml)
    }
  end

  defp parse_field(xml) do
    xml |> hd |> elem(2) |> hd
  end

  defp parse_header(xml) do
    %{
      type: Floki.find(xml, "submissiontype") |> parse_field,
      period: Floki.find(xml, "periodofreport") |> parse_field,
      file_number: Floki.find(xml, "form13ffilenumber") |> parse_field,
      company: %{
        name: Floki.find(xml, "name") |> parse_field,
        cik: Floki.find(xml, "cik") |> parse_field
      }
    }
  end

  defp parse_positions(xml) do
    xml
    |> Floki.find("infotable")
    |> Enum.map(fn position ->
      Floki.raw_html(position)
      |> Sec13FFilingParser.Position.parse()
    end)
  end
end
