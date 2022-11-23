defmodule Redoc.Plug.RedocUI do
  @moduledoc """
  A Plug for rendering Redoc UI.

  ## Usage

  If you're using Phoenix Framework, add Redoc UI by add this plug to the router:

  ```elixir
  scope "/api" do
    ...
    get "/redoc", Redoc.Plug.RedocUI, spec_url: "/spec/openapi"
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

  @impl true
  def init(opts) do
    spec_url = Keyword.fetch!(opts, :spec_url)
    redoc_version = Keyword.get(opts, :redoc_version, "latest")

    [spec_url: spec_url, redoc_version: redoc_version]
  end

  @impl true
  def call(conn, opts) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, EEx.eval_string(@index_html, opts))
  end
end
