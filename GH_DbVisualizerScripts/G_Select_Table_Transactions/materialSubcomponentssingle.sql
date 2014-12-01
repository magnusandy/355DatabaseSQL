SELECT
    matsub_matname,
    matsub_subcomponent
FROM
    public.v_materials_subcomponents
    where
     matsub_matname = ${mat||(null)||String}$ AND 
      matsub_subcomponent = ${matsub||(null)||String}$
      ;