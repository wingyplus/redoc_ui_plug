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
      <redoc
        <%= for {k, v} <- redoc_opts do %>
         <%= k %>="<%= v %>"
        <% end %>
      ></redoc>
      <script src="https://cdn.jsdelivr.net/npm/redoc@<%= Plug.HTML.html_escape(redoc_version) %>/bundles/redoc.standalone.js"></script>
    </body>
  </html>
  """

  @redoc_options [
    :disable_search,
    :download_definition_url,
    :download_file_name,
    :expand_default_server_variables,
    :expand_responses,
    :expand_single_schema_field,
    :generated_payload_samples_max_depth,
    :hide_download_button,
    :hide_fab,
    :hide_hostname,
    :hide_loading,
    :hide_schema_pattern,
    :hide_schema_titles,
    :hide_single_request_sample_tab,
    :json_sample_expand_level,
    :lazy_rendering,
    :max_displayed_enum_values,
    :menu_toggle,
    :min_character_length_to_init_search,
    :native_scrollbars,
    :nonce,
    :only_required_in_samples,
    :path_in_middle_panel,
    :payload_sample_idx,
    :required_props_first,
    :schema_expansion_level,
    :scroll_y_offset,
    :show_extensions,
    :show_object_schema_examples,
    :show_webhook_ver,
    :side_nav_style,
    :simple_one_of_type_label,
    :sort_enum_values_alphabetically,
    :sort_operations_alphabetically,
    :sort_props_alphabetically,
    :sort_tags_alphabetically,
    :spec_url,
    :theme,
    :untrusted_spec
  ]

  @impl true
  def init(opts) do
    redoc_opts = encode_options(opts)
    redoc_version = Keyword.get(opts, :redoc_version, "latest")

    [redoc_opts: redoc_opts, redoc_version: redoc_version]
  end

  @impl true
  def call(conn, opts) do
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, EEx.eval_string(@index_html, opts))
  end

  defp encode_options(opts) do
    Enum.reduce(opts, [], fn {key, value}, acc ->
      case Enum.member?(@redoc_options, key) do
        true -> [{to_kebab_case(key), value} | acc]
        false -> acc
      end
    end)
  end

  defp to_kebab_case(identifier) do
    identifier
    |> to_string()
    |> String.replace("_", "-")
  end
end
