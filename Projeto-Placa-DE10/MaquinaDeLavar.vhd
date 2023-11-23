library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MaquinaDeLavar is
    port(
        clock: in std_logic;
        sensorDeDistancia_1: in std_logic;
        sensorDeAgua: in std_logic;
		ativarCentrifugacao: in std_logic;
        botaoDeLigar: in std_logic;
        tampaFechada: out std_logic;
        liberarSabao: out std_logic;
        ligarMotor: out std_logic;
        ligarBombaDeAgua: out std_logic;
        abrirValvulaDeAgua: out std_logic;
        segs: out std_logic_vector( 6 downto 0 )
    );
end entity MaquinaDeLavar;

architecture Lavagem of MaquinaDeLavar is

----------------------- Instanciando componentes -------------------------

    component AdicaoDeAgua
        port(
            enable: in std_logic;
            sensorNivelAgua: in std_logic;
            nivelRoupas: in std_logic;
            fimDoEnchimento: out std_logic
        );
    end component AdicaoDeAgua;

    component DrenaAgua
        port(
            estadoDeAtivacao: in std_logic;
            sensorDeNivel: in std_logic;
            fimDaDrenagem: out std_logic
        );
    end component DrenaAgua;

    component NivelRoupas
        port(
            sensorDeDistancia_1: in std_logic;
            nivel: out std_logic
        );
    end component NivelRoupas;

    component Motor
        port(
            estadoDeAtivacao: in std_logic;
            temporizador: in std_logic;
            fimDaOperacao: out std_logic
        );
    end component Motor;

    component Temporizador
        port(
            enable: in std_logic;
            reset: in std_logic;
            clock: in std_logic;
            fim: out std_logic
        );
    end component Temporizador;

    component Display
        port(
            estado: in std_logic_vector( 3 downto 0 );
            display: out std_logic_vector( 6 downto 0 )
        );
    end component Display;

--------------------------------------------------------------------------

    type estados is ( inicial, enchimento1, lavagem, drenagem, enchimento2, enxague, drenagem2, centrifugacao );
    signal estadoAnterior, estadoAtual, estadoProximo: estados := inicial;

--------------------------------------------------------------------------

    signal botaoAnterior: std_logic := '0';
    signal ativarAdicaoDeAgua, ativarDrenagemDeAgua: std_logic := '0';
    signal pararAdicaoDeAgua, pararDrenagemDeAgua: std_logic := '0';
    signal ativarTemporizador, pararTemporizador: std_logic := '0';
    signal nivel: std_logic := '0';
    signal estadoParaDisplay: std_logic_vector( 3 downto 0 );

--------------------------------------------------------------------------

begin

    NR1: NivelRoupas port map(
        sensorDeDistancia_1,
        nivel
    );

    AA1: AdicaoDeAgua port map(
        ativarAdicaoDeAgua,
        sensorDeAgua,
        nivel,
        pararAdicaoDeAgua
    );

    DA1: DrenaAgua port map(
        ativarDrenagemDeAgua,
        sensorDeAgua,
        pararDrenagemDeAgua
    );

    T1: Temporizador port map(
        ativarTemporizador,
        pararTemporizador,
        clock,
        pararTemporizador
    );

    DSS: Display port map(
        estado => estadoParaDisplay,
        display => segs
    );

--------------------------------------------------------------------------

    processo_sincrono: process( clock, estadoProximo )
    
    begin

        if( rising_edge( clock ) ) then
            estadoAtual <= estadoProximo;
            botaoAnterior <= botaoDeLigar;
        end if;

    end process processo_sincrono;

--------------------------------------------------------------------------

    processo_combinacional: process( estadoAtual, botaoDeLigar, botaoAnterior, estadoAnterior, pararAdicaoDeAgua )
    
    begin

        case estadoAtual is

            when inicial =>
                tampaFechada <= '0';
                liberarSabao <= '0';
                ligarMotor <= '0';
                ligarBombaDeAgua <= '0';
                abrirValvulaDeAgua <= '0';

                ativarAdicaoDeAgua <= '0';
                ativarDrenagemDeAgua <= '0';
                ativarTemporizador <= '0';

                estadoParaDisplay <= "0000";

                if( botaoDeLigar = '1' and botaoAnterior = '0' ) then
                    estadoProximo <= enchimento1;
                else
                    estadoProximo <= inicial;
                end if;

            when enchimento1 =>
                tampaFechada <= '1';
                liberarSabao <= '0';
                ligarMotor <= '0';
                ligarBombaDeAgua <= '1';
                abrirValvulaDeAgua <= '0';

                ativarAdicaoDeAgua <= '1';
                ativarDrenagemDeAgua <= '0';
                ativarTemporizador <= '0';

                estadoParaDisplay <= "0001";

                if( botaoDeLigar = '1' and botaoAnterior = '0' ) then
                    estadoProximo <= lavagem;
                elsif( pararAdicaoDeAgua = '1' ) then
                    estadoProximo <= lavagem;
                else
                    estadoProximo <= enchimento1;
                end if;

            when lavagem =>
                tampaFechada <= '1';
                liberarSabao <= '1';
                ligarMotor <= '1';
                ligarBombaDeAgua <= '0';
                abrirValvulaDeAgua <= '0';

                ativarAdicaoDeAgua <= '0';
                ativarDrenagemDeAgua <= '0';
                ativarTemporizador <= '1';

                estadoParaDisplay <= "0010";

                if( botaoDeLigar = '1' and botaoAnterior = '0' ) then
                    estadoProximo <= drenagem;
                elsif( pararTemporizador = '1' ) then
                    estadoProximo <= drenagem;
                else
                    estadoProximo <= lavagem;
                end if;

            when drenagem =>
                tampaFechada <= '1';
                liberarSabao <= '0';
                ligarMotor <= '0';
                ligarBombaDeAgua <= '0';
                abrirValvulaDeAgua <= '1';

                ativarAdicaoDeAgua <= '0';
                ativarDrenagemDeAgua <= '1';
                ativarTemporizador <= '0';

                estadoParaDisplay <= "0011";

                if( botaoDeLigar = '1' and botaoAnterior = '0' ) then
                    estadoProximo <= enchimento2;
                elsif( pararDrenagemDeAgua = '1' ) then
                    estadoProximo <= enchimento2;
                else
                    estadoProximo <= drenagem;
                end if;

            when enchimento2 =>
                tampafechada <= '1';
                liberarSabao <= '0';
                ligarMotor <= '1';
                ligarBombaDeAgua <= '1';
                abrirValvulaDeAgua <= '0';

                ativarAdicaoDeAgua <= '1';
                ativarDrenagemDeAgua <= '0';
                ativarTemporizador <= '1';

                estadoParaDisplay <= "0100";

                if( botaoDeLigar = '1' and botaoAnterior = '0' ) then
                    estadoProximo <= enxague;
                elsif( pararAdicaoDeAgua = '1' ) then
                    estadoProximo <= enxague;
                else
                    estadoProximo <= enchimento2;
                end if;

            when enxague =>
                tampaFechada <= '1';
                liberarSabao <= '0';
                ligarMotor <= '1';
                ligarBombaDeAgua <= '0';
                abrirValvulaDeAgua <= '0';

                ativarAdicaoDeAgua <= '0';
                ativarDrenagemDeAgua <= '0';
                ativarTemporizador <= '1';

                estadoParaDisplay <= "0101";

                if( botaoDeLigar = '1' and botaoAnterior = '0' ) then
                    estadoProximo <= drenagem2;
                elsif( pararTemporizador = '1' ) then
                    estadoProximo <= drenagem2;
                else
                    estadoProximo <= enxague;
                end if;

            when drenagem2 =>
                tampafechada <= '1';
                liberarSabao <= '0';
                ligarMotor <= '0';
                ligarBombaDeAgua <= '0';
                abrirValvulaDeAgua <= '1';

                ativarAdicaoDeAgua <= '0';
                ativarDrenagemDeAgua <= '1';
                ativarTemporizador <= '1';

                estadoParaDisplay <= "0110";

                if( ( botaoDeLigar = '1' and botaoAnterior = '0' ) and ( ativarCentrifugacao = '1' ) ) then
                    estadoProximo <= centrifugacao;
                elsif( pararDrenagemDeAgua = '1' ) then
                    estadoProximo <= centrifugacao;
                else
                    estadoProximo <= drenagem2;
                end if;

            when centrifugacao =>
                tampafechada <= '1';
                liberarSabao <= '0';
                ligarMotor <= '1';
                ligarBombaDeAgua <= '0';
                abrirValvulaDeAgua <= '0';

                ativarAdicaoDeAgua <= '0';
                ativarDrenagemDeAgua <= '0';
                ativarTemporizador <= '1';

                estadoParaDisplay <= "0111";

                if( botaoDeLigar = '1' and botaoAnterior = '0' ) then
                    estadoProximo <= inicial;
                elsif( pararTemporizador = '1' ) then
                    estadoProximo <= inicial;
                else
                    estadoProximo <= centrifugacao;
                end if;

            when others =>
                tampafechada <= '0';
                liberarSabao <= '0';
                ligarMotor <= '0';
                ligarBombaDeAgua <= '0';
                abrirValvulaDeAgua <= '0';

                estadoProximo <= inicial;

        end case;

    end process processo_combinacional;

end architecture Lavagem;

--------------------------------------------------------------------------