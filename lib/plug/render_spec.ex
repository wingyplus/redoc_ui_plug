defmodule Redoc.Plug.RenderSpec do
  @moduledoc """
  Render openapi spec with add code example on each api. This plug is highly inspired
  by `OpenApiSpex.Plug.RenderSpec`.
  """

  @behaviour Plug

  import Plug.Conn

  alias OpenApiSpex.Plug.PutApiSpec

  @impl true
  def init(opts) do
    opts
  end

  @impl true
  def call(conn, _opts) do
    {spec, _} = PutApiSpec.get_spec_and_operation_lookup(conn)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(spec))
  end
end
