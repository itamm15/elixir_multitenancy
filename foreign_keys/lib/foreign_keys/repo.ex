defmodule ForeignKeys.Repo do
  use Ecto.Repo,
    otp_app: :foreign_keys,
    adapter: Ecto.Adapters.Postgres
end
