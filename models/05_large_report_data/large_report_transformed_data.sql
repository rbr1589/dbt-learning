with source_data as (
    select 
        (select network_type_id from {{ ref('network') }} where network_type = network limit 1) as network_type_id,
        (select season_type_id from {{ ref('season') }} where season_type = season limit 1) as season_type_id,
        (select component_type_id from {{ ref('component') }} where component_type = component limit 1) as component_type_id,
        "year" as "year",
		unnest(array['0-1 am', '6-7 pm', '7-8 am', '8-9 am', '12-1 pm', '4-5 pm', '2-3 am', '6-7 am', '7-8 pm', '10-11 pm', '1-2 am', '3-4 pm', '8-9 pm', '9-10 pm', '2-3 pm', '10-11 am', '1-2 pm', '5-6 am', '3-4 am', '11 am-12 pm', '11 pm-12 am', '5-6 pm', '4-5 am']) as "hour",
 		unnest(array["0-1 am", "6-7 pm", "7-8 am", "8-9 am", "12-1 pm", "4-5 pm", "2-3 am", "6-7 am", "7-8 pm", "10-11 pm", "1-2 am", "3-4 pm", "8-9 pm", "9-10 pm", "2-3 pm", "10-11 am", "1-2 pm", "5-6 am", "3-4 am", "11 am-12 pm", "11 pm-12 am", "5-6 pm", "4-5 am"]) as "value"
    from {{ ref('large_report_data_with_curated_year') }}
)

select * from source_data
