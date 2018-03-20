defmodule Countries do
  @moduledoc """
  Provides methods to search countries and access its information.
  """
  @countries_csv_file 'countries.csv'

  @doc """
  Returns country_code for the given country name.

  ## Examples

      iex> Countries.country_code("india")
      "356"

  """
  def country_code(country_name) do
    country(country_name).country_code
  end

  @doc """
  Returns country struct for the given country name.

  ## Examples

      iex> Countries.country("india")
      %Countries.Country{
        alpha_2: "IN",
        alpha_3: "IND",
        country_code: "356",
        iso_3166_2: "ISO 3166-2:IN",
        name: "India",
        region: "Asia",
        region_code: "142",
        sub_region: "Southern Asia",
        sub_region_code: "034"
      }

  """
  def country(country_name) do
    get_all_countries()
    |> Enum.find(%Countries.Country{}, fn %Countries.Country{name: name} ->
      String.downcase(name) == String.downcase(country_name)
    end)
  end

  @doc """
  Returns list of country names in a given region.

  ## Examples

      iex> Countries.list_countries("Oceania")
      ["American Samoa", "Australia", "Cook Islands", "Fiji", "French Polynesia",
       "Guam", "Kiribati", "Marshall Islands", "Micronesia (Federated States of)",
       "Nauru", "New Caledonia", "New Zealand", "Niue", "Norfolk Island",
       "Northern Mariana Islands", "Palau", "Papua New Guinea", "Pitcairn", "Samoa",
       "Solomon Islands", "Tokelau", "Tonga", "Tuvalu", "Vanuatu",
       "Wallis and Futuna"]

  """
  def list_countries(region) do
    get_all_countries()
    |> Enum.filter(fn %Countries.Country{region: region_for_country} ->
      String.downcase(region_for_country) == String.downcase(region)
    end)
    |> Enum.map(& &1.name)
  end

  @doc """
  Returns frequency of word in countries dataset.

  ## Examples

      iex> Countries.frequency("Asia")
      102

  """
  def frequency(word) do
    raw_file_data()
    |> tokenize
    |> Enum.count(&(&1 == word))
  end

  defp raw_file_data do
    {:ok, data} = File.read(@countries_csv_file)
    data
  end

  defp tokenize(sentence) do
    String.split(sentence, [",", " ", "\n"])
  end

  defp get_all_countries do
    read_countries_file()
    |> Enum.map(&parse_as_country_struct/1)
  end

  defp read_countries_file do
    File.stream!(@countries_csv_file)
    |> CSV.decode()
  end

  defp parse_as_country_struct(
         {:ok,
          [
            name,
            alpha_2,
            alpha_3,
            country_code,
            iso_3166_2,
            region,
            sub_region,
            region_code,
            sub_region_code
          ]} = _record
       ) do
    %Countries.Country{
      name: name,
      alpha_2: alpha_2,
      alpha_3: alpha_3,
      country_code: country_code,
      iso_3166_2: iso_3166_2,
      region: region,
      sub_region: sub_region,
      region_code: region_code,
      sub_region_code: sub_region_code
    }
  end
end
