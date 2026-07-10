defmodule Redoc do
  @moduledoc """
  A collection of modules to working with ReDoc.

  Please consult documentation in `Redoc.Plug.RedocUI` for
  more details.
  """

  @doc """
  A list of ReDoc options schema.
  """
  # NOTE: lazy_rendering doesn't add to this list since ReDoc documentation said it
  # it doesn't implement it yet.
  def options_schema() do
    [
      disable_search: [
        type: :boolean,
        default: false
      ],
      min_character_length_to_init_search: [
        type: :integer,
        default: 3
      ],
      expand_default_server_variables: [
        type: :boolean,
        default: false
      ],
      expand_responses: [
        type: :string,
        default: "all"
      ],
      generated_payload_samples_max_depth: [
        type: :integer,
        default: 10
      ],
      max_displayed_enum_values: [
        type: :integer
      ],
      hide_download_button: [
        type: :boolean,
        default: true
      ],
      download_file_name: [
        type: :string
      ],
      download_definition_url: [
        type: :string
      ],
      hide_hostname: [
        type: :boolean
      ],
      hide_loading: [
        type: :boolean
      ],
      hide_fab: [
        type: :boolean
      ],
      hide_schema_pattern: [
        type: :boolean
      ],
      hide_single_request_sample_tab: [
        type: :boolean
      ],
      show_object_schema_examples: [
        type: :boolean,
        default: false
      ],
      expand_single_schema_field: [
        type: :boolean
      ],
      schema_expansion_level: [
        type: {:or, [:integer, :string]},
        default: 0
      ],
      json_sample_expand_level: [
        type: {:or, [:integer, :string]},
        default: 0
      ],
      hide_schema_titles: [
        type: :boolean
      ],
      simple_one_of_type_label: [
        type: :boolean
      ],
      sort_enum_values_alphabetically: [
        type: :boolean
      ],
      sort_operations_alphabetically: [
        type: :boolean
      ],
      sort_tags_alphabetically: [
        type: :boolean
      ],
      menu_toggle: [
        type: :boolean,
        default: true
      ],
      native_scrollbars: [
        type: :boolean
      ],
      only_required_in_samples: [
        type: :boolean
      ],
      path_in_middle_panel: [
        type: :boolean
      ],
      required_props_first: [
        type: :boolean
      ],
      # NOTE: function not support.
      scroll_y_offset: [
        type: {:or, [:integer, :string]}
      ],
      show_extensions: [
        type: {:or, [:integer, :string, {:list, :string}]}
      ],
      sort_props_alphabetically: [
        type: :boolean
      ],
      payload_sample_idx: [
        type: :integer
      ],
      # TODO: revisit theme object.
      # theme: [
      #   type: :keyword_list
      # ]
      untrusted_spec: [
        type: :boolean
      ],
      nonce: [
        type: :string
      ],
      side_nav_style: [
        type: {:in, [:"summary-only", :"path-only", :"id-only"]}
      ],
      show_webhook_ver: [
        type: :boolean
      ],
      spec_url: [
        type: :string
      ]
    ]
  end
end
