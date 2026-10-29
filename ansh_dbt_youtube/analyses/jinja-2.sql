{%- set apples = ["Fuji", "Gala", "Honeycrisp"," Granny Smith", "Pink Lady", "Golden Delicious"] -%}

{%- for i in apples -%}
    {% if i != "Honeycrisp" %}
        {{ i }},
    {% else %}
        I hate {{ i }}
    {% endif %}
    
{%- endfor -%}