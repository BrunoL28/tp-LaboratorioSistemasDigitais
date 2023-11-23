library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_DrenaAgua is
end entity tb_DrenaAgua;

architecture teste of tb_DrenaAgua is

    component DrenaAgua
        port(
            estadoDeAtivacao : in std_logic;
            sensorDeNivel : in std_logic;
            fimDaDrenagem : out std_logic
        );
    end component DrenaAgua;

    signal estadoDeAtivacao : std_logic;
    signal sensorDeNivel : std_logic;
    signal fimDaDrenagem : std_logic;

begin

    instancia_teste: DrenaAgua port map(
        estadoDeAtivacao => estadoDeAtivacao,
        sensorDeNivel => sensorDeNivel,
        fimDaDrenagem => fimDaDrenagem
    );

    process

    begin

        estadoDeAtivacao <= '0', '1' after 20 ns;
        sensorDeNivel <= '0', '1' after 10 ns, '0' after 20 ns, '1' after 30 ns, '0' after 40 ns;

        wait for 50 ns;

        assert false report "Fim do teste" severity failure;

    end process;

end architecture teste;
