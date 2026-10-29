{%- set inc_flag = 1 -%}
{%- set last_load = 3 -%}

{% set column_list = ["date_sk", "customer_sk", "product_sk", "quantity"] %}

SELECT 
    {% for col in column_list %}
        {{ col }}{% if not loop.last %},{% endif %}
    {% endfor %}
FROM {{ ref('bronze_sales') }}
{% if inc_flag == 1 %}
WHERE date_sk > {{ last_load }}
{% endif %}