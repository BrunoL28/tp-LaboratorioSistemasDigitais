library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Temporizador is
    port(
        enable : in std_logic;
        reset : in std_logic;
        clock : in std_logic;
        fim : out std_logic
    );
end entity Temporizador;

architecture Temp of Temporizador is

begin

    process( clock, reset )

    variable count : natural := 0;
    constant max : natural := 10;

    begin

        if reset = '1' then
            count := 0;
            fim <= '0';
        elsif rising_edge( clock ) then
            if ( count < max ) then
                count := count + 1;
                fim <= '0';
            else
                fim <= '1';
            end if;
        end if;

    end process;

end architecture Temp;