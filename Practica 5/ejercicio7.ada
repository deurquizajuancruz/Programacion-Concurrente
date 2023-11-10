Procedure reconocimiento is

    Task especialista is
        entry huella(test: OUT string);
        entry resultado(codigo: IN integer, valor: IN integer);
    end especialista;

    Task type servidor;
    arrServidor: array(1..8) of servidor;
    
    Task body especialista is
        huellaTest: string;
        codigo, max, valor, codigoMax: integer;
    begin
        loop
            max:= -1;
            huellaTest = tomarHuella();

            for i:= 1..8 loop
                accept huella(test: OUT string) do
                    test:= huellaTest;
                end huella;
            end loop;

            for i:= 1..8 loop
                accept resultado(codigo: IN integer, valor: IN integer) do
                    if (valor > max) then
                        max:= valor;
                        codigoMax:= codigo;
                    end if;
                end resultado;
            end loop;
        end loop;
    end especialista;

    Task body servidor is
        test: string;
        codigo, valor: integer;
    begin
        loop
            especialista.huella(test);
            buscar(test, codigo, valor);
            especialista.resultado(codigo, valor);
        end loop;
    end servidor;

begin
    null;
end reconocimiento;