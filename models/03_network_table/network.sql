with networks as (
    select distinct(network)::varchar as network_type,
    md5(network)::varchar as network_type_id
    from {{ ref('large_report_data_with_curated_year') }}
)

select * from networks
