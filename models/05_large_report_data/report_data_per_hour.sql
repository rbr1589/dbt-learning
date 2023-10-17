with source_data as (
    select 
        md5(component)::varchar as component_type_id,
        md5(network)::varchar as network_type_id,
        md5(season) as season_type_id,
        "year" as "year",
		unnest(array['0-1 am', '6-7 pm', '7-8 am', '8-9 am', '12-1 pm', '4-5 pm', '2-3 am', '6-7 am', '7-8 pm', '10-11 pm', '1-2 am', '3-4 pm', '8-9 pm', '9-10 pm', '2-3 pm', '10-11 am', '1-2 pm', '5-6 am', '3-4 am', '11 am-12 pm', '11 pm-12 am', '5-6 pm', '4-5 am']) as "hour",
 		unnest(array["0-1 am", "6-7 pm", "7-8 am", "8-9 am", "12-1 pm", "4-5 pm", "2-3 am", "6-7 am", "7-8 pm", "10-11 pm", "1-2 am", "3-4 pm", "8-9 pm", "9-10 pm", "2-3 pm", "10-11 am", "1-2 pm", "5-6 am", "3-4 am", "11 am-12 pm", "11 pm-12 am", "5-6 pm", "4-5 am"]) as "value"
    from {{ ref('report_data_per_year') }}
)

select 
    n.network_type_id,
    s.season_type_id,
    c.component_type_id,
    sd.year,
    sd.hour,
    sd.value,
    {{ dbt_utils.generate_surrogate_key([
        '"sd"."network_type_id"',
        '"sd"."season_type_id"',
        '"sd"."component_type_id"',
        "year",
        "hour"]) 
    }} as id 
from source_data as sd

LEFT JOIN {{ ref('season') }} as s
ON s.season_type_id = sd.season_type_id

LEFT JOIN {{ ref('network') }} as n
ON n.network_type_id = sd.network_type_id

LEFT JOIN {{ ref('component') }} as c
ON c.component_type_id = sd.component_type_id