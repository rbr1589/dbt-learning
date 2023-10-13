with networks as (
    select distinct(network) as network_type,
    md5(network) as network_type_id
    from {{ ref('large_report_data_with_curated_year') }}
)

select * from networks
