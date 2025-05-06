library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity leds_control is
    Port ( sobrepeso : in STD_LOGIC;
           fallo_energia : in STD_LOGIC;
           puerta_bloqueada : in STD_LOGIC;
           puerta_abierta : in STD_LOGIC;
           puerta_cerrada : in STD_LOGIC;
           leds : out STD_LOGIC_VECTOR(4 downto 0));  -- 5 LEDs
end leds_control;

architecture Behavioral of leds_control is
begin
    process(sobrepeso, fallo_energia, puerta_bloqueada, puerta_abierta, puerta_cerrada)
    begin
        leds(0) <= sobrepeso;  -- LED de sobrepeso
        leds(1) <= fallo_energia;  -- LED de fallo de energía
        leds(2) <= puerta_bloqueada;  -- LED de puerta bloqueada
        leds(3) <= puerta_abierta;  -- LED de puerta abierta
        leds(4) <= puerta_cerrada;  -- LED de puerta cerrada
    end process;
end Behavioral;
