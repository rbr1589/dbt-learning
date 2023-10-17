
with mark_real_diffs as (

  select t.*, 
  case
    when id != previous_id then true 
      else false
    end as is_real_diff 
  from ( select 
    *,
    coalesce(
        lag(id) over (partition by "hour" order by "year"),
        'first_record'
    ) as previous_id
    from {{ ref('large_report_transformed_data') }}
  ) as t

),

filter_real_diffs as (

    select id, n.network_type_id, s.season_type_id, c.component_type_id, "year", "hour", "value"
  
    from mark_real_diffs mrd
    LEFT JOIN  {{ ref('network') }} n 
    ON n.network_type_id = mrd.network_type_id

    LEFT JOIN {{ ref('component') }} c
    ON c.component_type_id = mrd.component_type_id

    LEFT JOIN {{ ref('season') }} s
    ON s.season_type_id = mrd.season_type_id

    where is_real_diff = true

)

select * from filter_real_diffs