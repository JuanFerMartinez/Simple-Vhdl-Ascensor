library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  -- Librería para manejar unsigned e integer

entity temporizador is
    Port ( clk : in STD_LOGIC;  -- Reloj de la FPGA
           reset : in STD_LOGIC;  -- Reset
           enable : in STD_LOGIC;  -- Habilitar el temporizador
           tiempo_seg : in STD_LOGIC_VECTOR(31 downto 0);  -- Tiempo a contar (en segundos)
           tiempo_terminado : out STD_LOGIC);  -- Señal que se activa cuando el tiempo ha terminado
end temporizador;

architecture Behavioral of temporizador is
    signal contador : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');  -- Contador de 32 bits
begin
    process(clk, reset)
    begin
        if reset = '1' then
            contador <= (others => '0');  -- Reiniciar contador
            tiempo_terminado <= '0';  -- Resetea la señal de tiempo terminado
        elsif rising_edge(clk) then
            if enable = '1' then
                -- Convertimos el contador a unsigned para sumarlo correctamente
                if to_integer(unsigned(contador)) < to_integer(unsigned(tiempo_seg)) then
                    contador <= std_logic_vector(unsigned(contador) + 1);  -- Sumar 1 al contador
                    tiempo_terminado <= '0';  -- No ha terminado el tiempo aún
                else
                    tiempo_terminado <= '1';  -- El tiempo ha terminado
                end if;
            end if;
        end if;
    end process;
end Behavioral;
