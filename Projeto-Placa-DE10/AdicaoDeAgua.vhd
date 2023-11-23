library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AdicaoDeAgua is
    port(
        enable : in std_logic;
        sensorNivelAgua : in std_logic;
        nivelRoupas : in std_logic;
        fimDoEnchimento : out std_logic;
    );
end entity AdicaoDeAgua;

architecture Enchimento of AdicaoDeAgua is

begin

    process( enable, sensorNivelAgua, nivelRoupas )

    begin

        if( enable = '1' ) then
            if( nivelRoupas = '1' and sensorNivelAgua = '0' ) then
                fimDoEnchimento <= '0';
            elsif( nivelRoupas = '0' and sensorNivelAgua = '1' ) then
                fimDoEnchimento <= '1';
            elsif( nivelRoupas = '1' and sensorNivelAgua = '1' ) then
                fimDoEnchimento <= '1';
            else
                fimDoEnchimento <= '0';
            end if;
        else 
            fimDoEnchimento <= '0';
        end if;

    end process;

end architecture Enchimento;