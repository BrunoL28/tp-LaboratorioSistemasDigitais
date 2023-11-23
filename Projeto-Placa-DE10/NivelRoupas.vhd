library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NivelRoupas is
    port(
        sensorDeDistancia_1 : in std_logic;
        nivel : out std_logic
    );
end entity NivelRoupas;

architecture Medicao of NivelRoupas is

begin

	 process( sensorDeDistancia_1 )

    begin

		  if( sensorDeDistancia_1 = '1' ) then
            nivel <= '1';
        else
            nivel <= '0';
        end if;

    end process;

end architecture Medicao;
