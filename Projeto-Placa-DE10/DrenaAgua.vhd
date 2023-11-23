library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DrenaAgua is
    port(
        estadoDeAtivacao : in std_logic;
        sensorDeNivel : in std_logic;
        fimDaDrenagem : out std_logic
    );
end entity DrenaAgua;

architecture Escoamento of DrenaAgua is

    signal valorDoNivel : std_logic;

begin

    valorDoNivel <= sensorDeNivel;

    process( estadoDeAtivacao, valorDoNivel )

    begin

        if( estadoDeAtivacao = '1' ) then
            if( valorDoNivel = '1' ) then
                fimDaDrenagem <= '0';
            else
                fimDaDrenagem <= '1';
            end if;
        else
            fimDaDrenagem <= '0';
        end if;

    end process;

end architecture Escoamento;