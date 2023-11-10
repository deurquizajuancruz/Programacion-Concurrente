Procedure Banco is

    Task empleado is
        entry llegada(Comprobante: OUT string);
    end empleado;

    Task type cliente;
    arrClientes: array(1..N) of cliente;

    Task body empleado is
    begin
        loop
            accept llegada(Comprobante: OUT string);
                Comprobante = generarComprobante();
            end llegada;
        end loop;
    end empleado;

    Task body cliente is
        miComprobante: string;
    begin
        select
            empleado.llegada(miComprobante);
        or delay 600.0
            null;
        end select;
    end cliente;

begin
    null;
end Banco;