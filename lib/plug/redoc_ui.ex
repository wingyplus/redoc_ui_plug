defmodule Redoc.Plug.RedocUI do
  @plug_options_schema [
    title: [
      type: :string,
      default: "ReDoc",
      doc: "Custom ReDoc site title."
    ],
    spec_url: [
      type: :string,
      doc: "Open API spec URL.",
      deprecated: "Use `:spec_url` in `:redoc_opts` instead."
    ],
    redoc_version: [
      type: :string,
      default: "latest",
      doc: "Specify ReDoc version"
    ],
    redoc_options: [
      type: :keyword_list,
      keys: Redoc.options_schema(),
      doc: """
      ReDoc options. See https://github.com/Redocly/redoc#redoc-options-object for more details.
      """
    ]
  ]

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

  #{NimbleOptions.docs(@plug_options_schema)}
  """

  @behaviour Plug

  import Plug.Conn

  @index_html """
  <!doctype html>
  <html>
    <head>
      <title><%= title %></title
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
      <redoc
        <%= for {k, v} <- redoc_options do %>
          <%= k %>="<%= v %>"
        <% end %>
      ></redoc>
      <script src="https://cdn.jsdelivr.net/npm/redoc@<%= Plug.HTML.html_escape(redoc_version) %>/bundles/redoc.standalone.js"></script>
    </body>
  </html>
  """

  @impl true
  def init(opts) do
    case NimbleOptions.validate(opts, @plug_options_schema) do
      {:ok, opts} ->
	# Honor spec_url in the root of the `opts`.
        redoc_options =
          (opts[:redoc_options] || [])
          |> maybe_merge_spec_url(opts[:spec_url])
          |> encode_options()

        opts
        |> Keyword.delete(:redoc_options)
        |> Keyword.put(:redoc_options, redoc_options)

      otherwise ->
        otherwise
    end
  end

  @impl true
  def call(conn, opts) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, EEx.eval_string(@index_html, opts))
  end

  defp maybe_merge_spec_url(redoc_options, nil), do: redoc_options

  defp maybe_merge_spec_url(redoc_options, spec_url),
    do: Keyword.merge(redoc_options, spec_url: spec_url)

  # TODO: need test.
  defp encode_options(redoc_options) do
    Enum.map(redoc_options, fn {key, value} -> {to_kebab_case(key), value} end)
  end

  defp to_kebab_case(identifier) do
    identifier
    |> to_string()
    |> String.replace("_", "-")
  end
end
