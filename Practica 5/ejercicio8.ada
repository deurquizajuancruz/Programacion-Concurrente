Procedure limpieza is

    Task type camion;
    arrCamiones: array(1..3) of camion;

    Task type persona is
        entry identificacion(num: IN integer);
        entry atender();
    end persona;
    arrayPersonas: array(1..P) of persona;

    Task empresa is
        entry faltaAtencion(idPersona: IN integer);
        entry camionLibre(persona: OUT integer);
    end empresa;

    Task body camion is
        proxima: integer;
    begin
        loop
            empresa.camionLibre(proxima);
            persona(proxima).atender();
        end loop;
    end camion;

    Task body empresa is
        arrayContador: array;
        espera: boolean;
    begin
        espera:= false;
        loop
            select
                accept faltaAtencion(idPersona: IN integer) do
                    arrayContador(idPersona):=arrayContador(idPersona) + 1;
                    espera:= true;
                end faltaAtencion;
            or 
                when (espera) =>
                    accept camionLibre(persona: OUT integer) do
                        persona:= max(arrayContador);
                        arrayContador(max(arrayContador)):= 0;
                        espera:= false;
                    end camionLibre;
            end select;
        end loop;
    end empresa;

    Task body persona is
        atendido, miId: boolean;
    begin
        atendido:= false;
        accept identificacion(num: IN integer) do
            miId:= num;
        end identificacion;
        while (not atendido) loop
            empresa.faltaAtencion(miId);
            select
                accept atender();
                atendido:=true;
            or delay 900
                null;    
            end select;
        end loop;
    end persona;

begin
    for i:=1..P loop
        persona(i).identificacion(i);
    end loop;
end limpieza;