with source_data as (
    select _airbyte_large_report_hashid,
    cast("0-1 am" as float) as "0-1 am",
    cast("6-7 pm" as float) as "6-7 pm",
    cast("7-8 am" as float) as "7-8 am",
    cast("8-9 am" as float) as "8-9 am",
    cast("12-1 pm" as float) as "12-1 pm",
    cast("4-5 pm" as float) as "4-5 pm",
    cast("2-3 am" as float) as "2-3 am",
    cast("6-7 am" as float) as "6-7 am",
    cast("7-8 pm" as float) as "7-8 pm",
    cast("10-11 pm" as float) as "10-11 pm",
    cast("1-2 am" as float) as "1-2 am",
    cast("3-4 pm" as float) as "3-4 pm",
    cast("8-9 pm" as float) as "8-9 pm",
    cast("9-10 pm" as float) as "9-10 pm",
    cast("2-3 pm" as float) as "2-3 pm",
    cast("10-11 am" as float) as "10-11 am",
    cast("1-2 pm" as float) as "1-2 pm",
    cast("5-6 am" as float) as "5-6 am",
    cast("3-4 am" as float) as "3-4 am",
    cast("11 am-12 pm" as float) as "11 am-12 pm",
    cast("11 pm-12 am" as float) as "11 pm-12 am",
    cast("5-6 pm" as float) as "5-6 pm",
    cast("4-5 am" as float) as "4-5 am",
    convert_to_integer(large_report_data."year", component) as "year",
    get_network(large_report_data."year", network) as network,
    get_component(large_report_data."year", component, network) as component,
    season as season
    from large_report_data
)

select *
from source_data

/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null