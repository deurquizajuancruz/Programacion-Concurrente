Procedure sistema

    Task central is 
        entry proceso1();
        entry proceso2();
        entry finTiempo();
    end central;

    Task contador is
        entry empezar();
    end contador;

    Task periferico1;
    Task periferico2;

    Task body central is 
        recibir:boolean;
    begin
        accept proceso1();
        loop
            select
                accept proceso1();
            or
                accept proceso2() do
                    recibir:=false;
                    contador.empezar();
                    while (recibir = false) loop
                        select
                            when (finTiempo'count = 0) =>
                                accept proceso2();
                            or
                            accept finTiempo() do
                                recibir = true;
                            end finTiempo;
                        end select;
                    end loop;
                end proceso2;
            end select;
        end loop;
    end central;

    Task body contador is
    begin
        loop
            accept empezar();
            delay(180);
            central.finTiempo();
        end loop;
    end contador;

    Task body periferico1 is
        senial: string;
    begin
        loop
            senial = generarSenial();
            select
                central.proceso1(senial);
            or delay 120
                null;
        end loop;
    end periferico1;

    Task body periferico2 is
        senial: string;
        generar:boolean;
    begin
        generar:= true;
        loop
            if (generar)
                senial = generarSenial();
                generar:= false;
            end if;
            select
                central.proceso2(senial);
                generar:=true;
            else
                delay(60);
        end loop;
    end periferico2;

begin
    null;
end sistema;