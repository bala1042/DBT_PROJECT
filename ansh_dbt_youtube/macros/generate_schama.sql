{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- set env_name = target.name -%}

    {%- if env_name == "prod" -%}
        {# In production, use only the custom schema name if provided, otherwise the default target schema #}
        {{ custom_schema_name | trim if custom_schema_name else default_schema }}
    {%- else -%}
        {# In other environments (dev, CI), combine default and custom schema names to prevent collision #}
        {%- if custom_schema_name is none -%}
            {{ default_schema }}
        {%- else -%}
            {{ custom_schema_name | trim }}
        {%- endif -%}
    {%- endif -%}

{%- endmacro %}
