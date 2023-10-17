with seasons as (
    select distinct(season) as season_type,
    md5(season) as season_type_id
    from {{ ref('report_data_per_year') }}
)

select * from seasons
