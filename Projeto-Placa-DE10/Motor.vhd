library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Motor is
    port(
        estadoDeAtivacao : in std_logic;
        temporizador : in std_logic;
        fimDaOperacao : out std_logic
    );
end entity Motor;

architecture Func of Motor is

begin

    process( estadoDeAtivacao, temporizador )
        
    begin

        if estadoDeAtivacao = '1' then
            if temporizador = '1' then
                fimDaOperacao <= '1';
            elsif temporizador = '0' then
                fimDaOperacao <= '0';
            end if;
        else
            fimDaOperacao <= '0';
        end if;

    end process;

end architecture Func;