defmodule Redoc.Plug.RedocUI do
  @moduledoc """
  A Plug for rendering Redoc UI.

  ## Usage

  If you're using Phoenix Framework, add Redoc UI by add this plug to the router:

  ```elixir
  scope "/api" do
    ...
    get "/redoc", Redoc.Plug.RedocUI, spec: "/spec/openapi" 
  end
  ```

  ## Options

  * `spec_url` - The openapi path to fetch. Support both `yaml` and `json`.
  * `redoc_version` - Specify a Redoc version, default to `latest`.
  """

  @behaviour Plug

  import Plug.Conn

  @index_html """
  <!doctype html>
  <html>
    <head>
      <title>ReDoc</title
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,700|Roboto:300,400,700" rel="stylesheet">

      <style>
        body {
          margin: 0;
          padding: 0;
        }
      </style>
    </head>
    <body>
      <redoc spec-url="<%= spec_url %>"></redoc>
      <script src="https://cdn.jsdelivr.net/npm/redoc@<%= Plug.HTML.html_escape(redoc_version) %>/bundles/redoc.standalone.js"></script>
    </body>
  </html>
  """

  @supported_opts [
    :spec_url,
    :redoc_version
  ]

  @impl true
  def init(opts) do
    # TODO: validate mandatory fields.
    Keyword.take(opts, @supported_opts)
    |> Keyword.validate!([:spec_url, redoc_version: "latest"])
  end

  @impl true
  def call(conn, opts) do
    conn
    |> send_resp(200, EEx.eval_string(@index_html, opts))
  end
end
