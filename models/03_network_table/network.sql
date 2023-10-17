with networks as (
    select distinct(network)::varchar as network_type,
    md5(network)::varchar as network_type_id
    from {{ ref('report_data_per_year') }}
)

select * from networks
