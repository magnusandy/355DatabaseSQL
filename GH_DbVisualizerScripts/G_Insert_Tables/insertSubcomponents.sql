INSERT 
INTO 
public.t_materials_subcomponents 
        (
                matsub_matname, 
                matsub_subcomponent
        )
VALUES
        (
                ${matname||(null)||String}$, 
                ${subcomponent||(null)||String}$
        )
;


--tested, works