with components as (
    select distinct(component) as component_type,
    md5(component) as component_type_id
    from {{ ref('large_report_data_with_curated_year') }}
)

select * from components
