Procedure carreras

    Task type usuarios;
    arrUsuarios: array(1..U) of usuarios;

    Task servidor is
        entry documento(d: IN string, valido: OUT boolean);
    end servidor;

    Task body usuarios is
        d: string;
        valido, trabajar, diferente: boolean;
    begin
        trabajar:= true;
        diferente:= true;
        while (trabajar) loop
            if (diferente) then
                trabajarDocumento(d);
                diferente:=false;
            select
                servidor.documento(d,valido);
                if (valido) then
                    trabajar:= false;
                else
                    diferente:=true;
                end if;
            or delay 120
                delay(60);
        end loop;
    end usuarios;

    Task body servidor is
        valido: boolean;
        documento: string;
    begin
        loop
            accept documento(d: IN string, valido: OUT boolean) do
                valido = verificar();
            end accept;
        end loop;
    end servidor;

begin
    null;
end carreras;