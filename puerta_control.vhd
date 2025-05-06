library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity puerta_control is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           abrir : in STD_LOGIC;
           cerrar : in STD_LOGIC;
           tiempo_espera_abrir : in STD_LOGIC_VECTOR(31 downto 0);  -- Añadido
           tiempo_espera_cerrar : in STD_LOGIC_VECTOR(31 downto 0);  -- Añadido
           puerta_abierta : out STD_LOGIC;
           puerta_cerrada : out STD_LOGIC);
end puerta_control;

architecture Behavioral of puerta_control is
    signal tiempo_terminado_abrir : STD_LOGIC;
    signal tiempo_terminado_cerrar : STD_LOGIC;
    signal enable_abrir : STD_LOGIC := '0';
    signal enable_cerrar : STD_LOGIC := '0';

    -- Instancia del temporizador para la puerta
    component temporizador
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               enable : in STD_LOGIC;
               tiempo_seg : in STD_LOGIC_VECTOR(31 downto 0);
               tiempo_terminado : out STD_LOGIC);
    end component;

begin
    -- Temporizador para abrir la puerta (10 segundos)
    U1: temporizador port map(clk, reset, enable_abrir, "00000000000000000000000000001010", tiempo_terminado_abrir); -- 10 segundos

    -- Temporizador para cerrar la puerta (45 segundos)
    U2: temporizador port map(clk, reset, enable_cerrar, "00000000000000000000000000101101", tiempo_terminado_cerrar); -- 45 segundos

    -- Lógica para manejar el control de la puerta
    process(abrir, cerrar, tiempo_terminado_abrir, tiempo_terminado_cerrar)
    begin
        -- Inicializar valores por defecto para evitar latches
        puerta_abierta <= '0';  -- Definir valores por defecto
        puerta_cerrada <= '0';
        enable_abrir <= '0';
        enable_cerrar <= '0';

        if abrir = '1' then
            puerta_abierta <= '1';
            puerta_cerrada <= '0';
            enable_abrir <= '1';  -- Iniciar temporizador para abrir
        elsif tiempo_terminado_abrir = '1' then
            enable_abrir <= '0';  -- Detener temporizador de abrir
        end if;

        if cerrar = '1' then
            puerta_abierta <= '0';
            puerta_cerrada <= '1';
            enable_cerrar <= '1';  -- Iniciar temporizador para cerrar
        elsif tiempo_terminado_cerrar = '1' then
            enable_cerrar <= '0';  -- Detener temporizador de cerrar
        end if;
    end process;

end Behavioral;
