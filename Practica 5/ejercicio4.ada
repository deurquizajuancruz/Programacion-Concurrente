Procedure clinica 

    Task medico is
        entry persona(solicitud: IN string, resultado: OUT string);
        entry enfermera(solicitud: IN string);
        entry consultorio(n: IN string);
    end medico;

    Task escritorio is 
        entry nota(n: IN string);
        entry mandarNota(ultimaNota: OUT string)
    end escritorio;

    Task administrador;

    Task type persona;
    arrPersonas: array(1..P) of persona;

    Task type enfermera;
    arrEnfermera: array (1..E) of enfermera;

    Task body persona is
        terminar: boolean;
        contador: integer;
        solicitud, resultado: string;
    begin
        contador:= 0;
        terminar:= false;
        while (terminar = false) loop
            select
                medico.persona(solicitud, resultado);
                terminar:= true;
            or delay 300
                contador:= contador + 1;
                if (contador = 3) then
                    terminar:= true;
                else
                    delay(600);
                end if;
        end loop;
    end persona;

    Task body enfermera is
        solicitud, n: string;
    begin
        loop
            trabajar();
            select
                medico.enfermera(solicitud);
            else
                escritorio.nota(n);
        end loop;
    end enfermera;

    Task body medico is
    begin
        loop
            select
                accept persona(solicitud: IN string, resultado: OUT string) do
                    resultado = atenderEnfermo();
                end persona;
                or 
                when (persona'count = 0) =>
                    accept enfermera(solicitud: IN string) do
                        procesarSolicitud(solicitud);
                    end enfermera;
                or
                when (persona'count = 0) and (enfermera'count = 0) =>
                    accept consultorio(n: IN string) do
                        procesarNota(n);
                    end consultorio;
            end select;
        end loop;
    end medico;

    Task body administrador is
        ultimaNota:string;
    begin
        loop
            escritorio.mandarNota(ultimaNota);
            medico.consultorio(ultimaNota);
        end loop;
    end administrador;

    Task body escritorio is
        notas: cola;
    begin
        loop
            select
                accept nota(n: IN string) do
                    notas.push(n);
                end nota;
            or
                when (not notas.isEmpty()) =>
                    accept mandarNota(ultimaNota: OUT string) do
                        ultimaNota = notas.pop();
                    end mandarNota;
            end select;
        end loop;
    end escritorio;

begin
    null;
end clinica;