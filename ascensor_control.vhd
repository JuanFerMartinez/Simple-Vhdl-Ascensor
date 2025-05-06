library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ascensor_control is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           dip_switch : in STD_LOGIC_VECTOR(10 downto 0);
           abrir : in STD_LOGIC;
           cerrar : in STD_LOGIC;
           botones : in STD_LOGIC_VECTOR(9 downto 0);
           botones_int : in STD_LOGIC_VECTOR(4 downto 0);
           sobrepeso : out STD_LOGIC;
           fallo_energia : in STD_LOGIC;
           puerta_bloqueada : in STD_LOGIC;
           buzzer : out STD_LOGIC;
           leds : out STD_LOGIC_VECTOR(4 downto 0);
           seg1 : out STD_LOGIC_VECTOR(6 downto 0);
           seg2 : out STD_LOGIC_VECTOR(6 downto 0));
end ascensor_control;

architecture Behavioral of ascensor_control is
    signal piso_llamado : STD_LOGIC_VECTOR(2 downto 0);
    signal piso_interno : STD_LOGIC_VECTOR(2 downto 0);
    signal piso_seleccionado : STD_LOGIC_VECTOR(2 downto 0);
    signal puerta_abierta : STD_LOGIC;
    signal puerta_cerrada : STD_LOGIC;
    signal tiempo_terminado_abrir : STD_LOGIC;
    signal tiempo_terminado_cerrar : STD_LOGIC;
    signal enable_abrir : STD_LOGIC := '0';
    signal enable_cerrar : STD_LOGIC := '0';
    signal tiempo_espera_abrir : STD_LOGIC_VECTOR(31 downto 0) := x"0000000A";
    signal tiempo_espera_cerrar : STD_LOGIC_VECTOR(31 downto 0) := x"0000002D";
    signal sobrepeso_signal : STD_LOGIC;

    component conteo_personas is
        Port ( dip_switch : in STD_LOGIC_VECTOR(10 downto 0);
               sobrepeso : out STD_LOGIC);
    end component;

    component buzzer_control is
        Port ( sobrepeso : in STD_LOGIC;
               fallo_energia : in STD_LOGIC;
               puerta_bloqueada : in STD_LOGIC;
               buzzer : out STD_LOGIC);
    end component;

    component puerta_control is
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               abrir : in STD_LOGIC;
               cerrar : in STD_LOGIC;
               tiempo_espera_abrir : in STD_LOGIC_VECTOR(31 downto 0);
               tiempo_espera_cerrar : in STD_LOGIC_VECTOR(31 downto 0);
               puerta_abierta : out STD_LOGIC;
               puerta_cerrada : out STD_LOGIC);
    end component;

    component display_pisos is
        Port ( piso : in STD_LOGIC_VECTOR(2 downto 0);
               seg1 : out STD_LOGIC_VECTOR(6 downto 0);
               seg2 : out STD_LOGIC_VECTOR(6 downto 0));
    end component;

    component leds_control is
        Port ( sobrepeso : in STD_LOGIC;
               fallo_energia : in STD_LOGIC;
               puerta_bloqueada : in STD_LOGIC;
               puerta_abierta : in STD_LOGIC;
               puerta_cerrada : in STD_LOGIC;
               leds : out STD_LOGIC_VECTOR(4 downto 0));
    end component;

    component botones_externos is
        Port ( botones : in STD_LOGIC_VECTOR(9 downto 0);
               piso_llamado : out STD_LOGIC_VECTOR(2 downto 0));
    end component;

    component botones_internos is
        Port ( botones_int : in STD_LOGIC_VECTOR(4 downto 0);
               piso_seleccionado : out STD_LOGIC_VECTOR(2 downto 0));
    end component;

begin
    U1: conteo_personas port map(dip_switch, sobrepeso_signal);
    U2: buzzer_control port map(sobrepeso_signal, fallo_energia, puerta_bloqueada, buzzer);
    U3: puerta_control port map(clk, reset, abrir, cerrar, tiempo_espera_abrir, tiempo_espera_cerrar, puerta_abierta, puerta_cerrada);
    U4: display_pisos port map(piso_seleccionado, seg1, seg2);
    U5: leds_control port map(sobrepeso_signal, fallo_energia, puerta_bloqueada, puerta_abierta, puerta_cerrada, leds);
    U6: botones_externos port map(botones => botones, piso_llamado => piso_llamado);
    U7: botones_internos port map(botones_int => botones_int, piso_seleccionado => piso_interno);

    sobrepeso <= sobrepeso_signal;

    process(clk, reset)
    begin
        if reset = '1' then
            piso_seleccionado <= "000";
        elsif rising_edge(clk) then
            if piso_llamado /= piso_seleccionado then
                if piso_llamado > piso_seleccionado then
                    piso_seleccionado <= std_logic_vector(unsigned(piso_seleccionado) + 1);
                elsif piso_llamado < piso_seleccionado then
                    piso_seleccionado <= std_logic_vector(unsigned(piso_seleccionado) - 1);
                end if;
            elsif piso_interno /= piso_seleccionado then
                if piso_interno > piso_seleccionado then
                    piso_seleccionado <= std_logic_vector(unsigned(piso_seleccionado) + 1);
                elsif piso_interno < piso_seleccionado then
                    piso_seleccionado <= std_logic_vector(unsigned(piso_seleccionado) - 1);
                end if;
            end if;
        end if;
    end process;

end Behavioral;