defmodule Countries.Country do
  @typedoc """
  Defines the Country struct.

  * `:name` - name of country
  * `:region` - region of the country
  * `:country_code` - country code for the country
  """
  @type t :: %__MODULE__{
    name: nil | String.t,
    region: nil | String.t,
    country_code: nil | integer()
  }

  defstruct name: nil,
            alpha_2: nil,
            alpha_3: nil,
            country_code: nil,
            iso_3166_2: nil,
            region: nil,
            sub_region: nil,
            region_code: nil,
            sub_region_code: nil
end
