library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_AdicaoDeAgua is
end entity tb_AdicaoDeAgua;

architecture teste of tb_AdicaoDeAgua is

    component AdicaoDeAgua is
        port(
            enable : in std_logic;
            sensorNivelAgua : in std_logic;
            nivelRoupas : in std_logic;
            fimDoEnchimento : out std_logic
        );
    end component AdicaoDeAgua;

    signal enable : std_logic;
    signal sensorNivelAgua : std_logic;
    signal nivelRoupas : std_logic;
    signal fimDoEnchimento : std_logic;

begin

    instancia_teste: AdicaoDeAgua port map(
        enable => enable,
        sensorNivelAgua => sensorNivelAgua,
        nivelRoupas => nivelRoupas,
        fimDoEnchimento => fimDoEnchimento
    );

    process

    begin

        enable <= '0', '1' after 20 ns;
        sensorNivelAgua <= '0', '1' after 5 ns, '0' after 20 ns, '1' after 40 ns;
        nivelRoupas <= '0', '1' after 10 ns, '0' after 20 ns, '1' after 30 ns, '0' after 40 ns, '1' after 45 ns;

        wait for 50 ns;

        assert false report "Fim do teste" severity failure;

    end process;

end architecture teste;