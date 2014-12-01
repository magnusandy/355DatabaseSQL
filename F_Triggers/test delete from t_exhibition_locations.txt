begin;
update t_item_locations  set ilo_locname = 'Gallery B' where ilo_ilodatetime_start >= cast('2015-01-26' as timestamp) and ilo_inumkey in (select exi_inumkey from t_exhibition_items where exi_ename = 'Masks and Jewlery');

select * from t_exhibition_locations where exl_ename = 'Masks and Jewlery';
select * from t_item_locations where ilo_inumkey in (select exi_inumkey from t_exhibition_items where exi_ename = 'Masks and Jewlery') and ilo_ilodatetime_start >= now();

delete from t_exhibition_locations where exl_ename = 'Masks and Jewlery';

select * from t_item_locations where ilo_inumkey in (select exi_inumkey from t_exhibition_items where exi_ename = 'Masks and Jewlery') and ilo_ilodatetime_start >= now();

select * from t_exhibition_locations where exl_ename= 'Masks and Jewlery';


select * from t_exhibition_locations where exl_ename = 'Fabulous Furniture';
select * from t_item_locations where ilo_inumkey in (select exi_inumkey from t_exhibition_items where exi_ename = 'Fabulous Furniture') and ilo_ilodatetime_start <= now() and (ilo_ilodatetime_end >= now() or ilo_ilodatetime_end is null);
delete from t_exhibition_locations where exl_ename = 'Fabulous Furniture';

select * from t_exhibition_locations where exl_ename = 'Fabulous Furniture';
select * from t_item_locations where ilo_inumkey in (select exi_inumkey from t_exhibition_items where exi_ename = 'Fabulous Furniture') and ilo_ilodatetime_start <= now() and (ilo_ilodatetime_end >= now() or ilo_ilodatetime_end is null);

--delete when it has occurred in the past.