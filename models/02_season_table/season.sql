with seasons as (
    select distinct(season) as season_type,
    md5(season) as season_type_id
    from {{ ref('large_report_data_with_curated_year') }}
)

select * from seasons
