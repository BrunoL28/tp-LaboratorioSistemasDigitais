library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_Motor is
end entity tb_Motor;

architecture teste of tb_Motor is

    component Motor
        port(
            estadoDeAtivacao : in std_logic;
            temporizador : in std_logic;
            fimDaOperacao : out std_logic
        );
    end component Motor;

    signal estadoDeAtivacao : std_logic;
    signal temporizador : std_logic;
    signal fimDaOperacao : std_logic;

begin

    instancia_teste: Motor port map(
        estadoDeAtivacao => estadoDeAtivacao,
        temporizador => temporizador,
        fimDaOperacao => fimDaOperacao
    );

    process

    begin

        estadoDeAtivacao <= '0', '1' after 20 ns;
        temporizador <= '0', '1' after 10 ns, '0' after 20 ns, '1' after 30 ns, '0' after 40 ns;

        wait for 50 ns;

        assert false report "Fim do teste" severity failure;

    end process;

end architecture teste;