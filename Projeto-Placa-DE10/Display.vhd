library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Display is
    port(
        estado: in std_logic_vector( 3 downto 0 );
        display: out std_logic_vector( 6 downto 0 )
    );
end entity Display;

architecture SeteSegmentos of Display is

begin

    process( estado )

    begin

        case estado is

            when "0000" =>      --0
                display <= "1000000";
            when "0001" =>      --1
                display <= "1111001";
            when "0010" =>      --2
                display <= "0100100";
            when "0011" =>      --3
                display <= "0110000";
            when "0100" =>      --4
                display <= "0011001";
            when "0101" =>      --5
                display <= "0010010";
            when "0110" =>      --6
                display <= "0000010";
            when "0111" =>      --7
                display <= "1111000";
            when others =>      --nada
                display <= "1111111";

        end case;

    end process;

end architecture SeteSegmentos;