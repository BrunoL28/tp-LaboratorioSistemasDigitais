library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_NivelRoupas is
end entity tb_NivelRoupas;

architecture teste of tb_NivelRoupas is

    component NivelRoupas
        port(
            sensorDeDistancia_1 : in std_logic;
            nivel : out std_logic
        );
    end component NivelRoupas;

    signal sensorDeDistancia_1 : std_logic;
    signal nivel : std_logic;

begin

    instancia_teste: NivelRoupas port map(
        sensorDeDistancia_1 => sensorDeDistancia_1,
        nivel => nivel
    );

    process

    begin

        sensorDeDistancia_1 <= '0', '1' after 10 ns, '0' after 12 ns, '1' after 23 ns, '0' after 30 ns, '1' after 35 ns, '0' after 40 ns, '1' after 45 ns;

        wait for 50 ns;

        assert false report "Fim do teste" severity failure;

    end process;

end architecture teste;