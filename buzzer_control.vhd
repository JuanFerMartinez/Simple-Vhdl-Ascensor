library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity buzzer_control is
    Port ( sobrepeso : in STD_LOGIC;  -- Señal de sobrepeso
           fallo_energia : in STD_LOGIC;  -- Señal de fallo de energía
           puerta_bloqueada : in STD_LOGIC;  -- Señal de puerta bloqueada
           buzzer : out STD_LOGIC);  -- Buzzer activado
end buzzer_control;

architecture Behavioral of buzzer_control is
begin
    process(sobrepeso, fallo_energia, puerta_bloqueada)
    begin
        -- El buzzer debe estar activado (1) cuando haya sobrepeso, fallo de energía o puerta bloqueada
        if sobrepeso = '1' or fallo_energia = '1' or puerta_bloqueada = '1' then
            buzzer <= '1';  -- Buzzer encendido (alarma activada)
        else
            buzzer <= '0';  -- Buzzer apagado (sin alarma)
        end if;
    end process;
end Behavioral;
