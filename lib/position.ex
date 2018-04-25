defmodule Sec13FFilingParser.Position do
  @moduledoc """
  Documentation for the Position object
  """

  defp parse_field(xml) do
    xml |> hd |> elem(2) |> hd
  end

  def parse(xml) do
    %{
      name: Floki.find(xml, "nameofissuer") |> parse_field(),
      cusip: Floki.find(xml, "cusip") |> parse_field(),
      est_value: Floki.find(xml, "value") |> parse_field(),
      est_amount: Floki.find(xml, "sshprnamt") |> parse_field(),
      type: Floki.find(xml, "sshprnamttype") |> parse_field()
    }
  end
end
