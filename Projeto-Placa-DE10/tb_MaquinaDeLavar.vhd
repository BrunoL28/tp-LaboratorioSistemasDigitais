library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_MaquinaDeLavar is
end entity tb_MaquinaDeLavar;

architecture teste of tb_MaquinaDeLavar is

	 constant clockPeriod : time := 10 ns;
	 constant dutyCicle : real := 0.5;
	 constant offset : time := 5 ns;

    component MaquinaDeLavar
        port(
            clock: in std_logic;
            sensorDeDistancia_1: in std_logic;
            sensorDeAgua: in std_logic;
            botaoDeLigar: in std_logic;
            tampaFechada: out std_logic;
            liberarSabao: out std_logic;
            ligarMotor: out std_logic;
            ligarBombaDeAgua: out std_logic;
            abrirValvulaDeAgua: out std_logic;
            segs: out std_logic_vector( 6 downto 0 )
        );
    end component MaquinaDeLavar;

    signal clock, sensorDeDistancia_1, sensorDeAgua, botaoDeLigar: std_logic := '0';
    signal tampaFechada, liberarSabao, ligarMotor, ligarBombaDeAgua, abrirValvulaDeAgua: std_logic := '0';
    signal segs: std_logic_vector( 6 downto 0 ) := "0000000";

begin

    instancia_teste: MaquinaDeLavar port map(
        clock => clock,
        sensorDeDistancia_1 => sensorDeDistancia_1,
        sensorDeAgua => sensorDeAgua,
        botaoDeLigar => botaoDeLigar,
        tampaFechada => tampaFechada,
        liberarSabao => liberarSabao,
        ligarMotor => ligarMotor,
        ligarBombaDeAgua => ligarBombaDeAgua,
        abrirValvulaDeAgua => abrirValvulaDeAgua,
        segs => segs
    );
	 
	 process is
	 
	 begin
	 
		wait for offset;
		
			clockLoop: loop
				
				clock <= '0';
				wait for ( clockPeriod - ( clockPeriod * dutyCicle ) );
				clock <= '1';
				wait for ( clockPeriod * dutyCicle );
				
			end loop ClockLoop;
			
	 end process;
	 
	process is
	
	begin
	
		wait for offset;
		
		sensorDeDistancia_1 <= '1';
		
		wait for clockPeriod;
		
		botaoDeLigar <= '1';
		
		wait for clockPeriod;
		
		sensorDeAgua <= '0';
		
		wait for clockPeriod;
		
		sensorDeAgua <= '1';
		
		wait for clockPeriod;
		
		sensorDeAgua <= '0';
		
		wait for clockPeriod;
		
		sensorDeAgua <= '1';
		
		wait for clockPeriod;
		
		botaoDeLigar <= '0';
		
		
	end process;
	 
end architecture teste;