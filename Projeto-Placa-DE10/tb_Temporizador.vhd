library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_Temporizador is
end entity tb_Temporizador;

architecture teste of tb_Temporizador is

    component Temporizador
        port(
            enable : in std_logic;
            reset : in std_logic;
            clock : in std_logic;
            fim : out std_logic
        );
    end component Temporizador;

    signal enable : std_logic;
    signal reset : std_logic;
    signal clock : std_logic;
    signal fim : std_logic;

begin

    instancia_teste: Temporizador port map(
        enable => enable,
        reset => reset,
        clock => clock,
        fim => fim
    );

    process

    begin

        enable <= '0', '1' after 15 ns;
        reset <= '0';
        clock <= '0', '1' after 5 ns, '0' after 10 ns, '1' after 15 ns, '0' after 20 ns, '1' after 25 ns, '0' after 30 ns, '1' after 35 ns, '0' after 40 ns, '1' after 45 ns, '0' after 50 ns, '1' after 55 ns, '0' after 60 ns, '1' after 65 ns, '0' after 70 ns, '1' after 75 ns, '0' after 80 ns, '1' after 85 ns, '0' after 90 ns, '1' after 95 ns, '0' after 100 ns, '1' after 105 ns, '0' after 110 ns, '1' after 115 ns, '0' after 120 ns, '1' after 125 ns;

        wait for 130 ns;

        assert false report "Fim do teste" severity failure;

    end process;

end architecture teste;