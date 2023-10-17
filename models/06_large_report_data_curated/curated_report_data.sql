
with mark_real_diffs as (

  select t.*, 
  case
    when id != previous_id then true 
      else false
    end as is_real_diff 
  from ( select 
    *,
    coalesce(
        lag(id) over (partition by "hour", "year", "season_type_id", "component_type_id", "network_type_id" order by "year"),
        'first_record'
    ) as previous_id
    from {{ ref('report_data_per_hour') }}
  ) as t

),

filter_real_diffs as (

    select id, network_type_id, season_type_id, component_type_id, "year", "hour", "value"
    from mark_real_diffs
    where is_real_diff = true

)

select * from filter_real_diffs