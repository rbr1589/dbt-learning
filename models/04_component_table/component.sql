with components as (
    select distinct(component)::varchar as component_type,
    md5(component)::varchar as component_type_id
    from {{ ref('report_data_per_year') }}
)

select * from components
