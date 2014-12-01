DELETE FROM public.t_materials_subcomponents WHERE matsub_matname = ${mat||(null)||String}$ and matsub_subcomponent = ${sub||(null)||String}$;
--tested works
