Procedure playa

    Task type administrador is
        entry equipo(numero: IN integer);
        entry llegada();
        entry espera();
        entry total(total: IN integer);
    end administrador;
    arrayAdmin: array(1..5) of administrador;

    Task type personas;
    arrayPersonas: array(1..20) of personas;

    Task coordinador is
        entry totalEquipo(totalE: IN integer, numE: IN integer);
        entry quienGano(equipoGanador: OUT integer);
    end coordinador;

    Task body personas is
        miEquipo, monto, ganador: integer;
    begin
        monto:= 0;
        administrador(miEquipo).llegada();
        administrador(miEquipo).espera();
        for i:= 1 to 15 loop
            monto:= monto + moneda();
        end loop;
        administrador(miEquipo).total(monto);
        coordinador.quienGano(ganador);
    end personas;

    Task body administrador is
        contador, miE: integer;
    begin
        contador:= 0;
        accept miE(numero: IN integer) do
            miE := numero;
        end miE;

        for i:= 1 to 4 loop
            accept llegada();
        end loop;

        for i:= 1 to 4 loop
            accept espera();
        end loop;

        for i:= 1 to 4 loop
            accept total(total: IN integer) do
                contador:= contador + total;
            end total;
        end loop;

        coordinador.totalEquipo(contador, miE);
        
    end administrador;

    Task body coordinador is 
        totalE, numE, max, ganador: integer;
    begin
        max:= -1;
        for i:= 1..5 loop
            accept totalEquipo(totalE: IN integer, numE: IN integer) do 
                if (totalE > max) then
                    max:= totalE;
                    ganador:= numE;
                end if;
            end totalEquipo;
        end loop;

        for i:=1..20 loop
            accept quienGano(equipoGanador: OUT integer) do
                equipoGanador:= ganador;
        end loop;
    end coordinador;
begin
    for i:= 1..5 loop
        arrayAdmin(i).equipo(i);
    end loop;
end playa;