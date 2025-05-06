library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity botones_internos is
    Port ( botones_int : in STD_LOGIC_VECTOR(4 downto 0);  -- Entradas activas en bajo
           piso_seleccionado : out STD_LOGIC_VECTOR(2 downto 0));  -- Piso al que se desea ir
end botones_internos;

architecture Behavioral of botones_internos is
begin
    process(botones_int)
    begin
        -- Lógica para detectar cuál botón está en '0' (presionado)
        case botones_int is
            when "11110" => piso_seleccionado <= "001";  -- Piso 1
            when "11101" => piso_seleccionado <= "010";  -- Piso 2
            when "11011" => piso_seleccionado <= "011";  -- Piso 3
            when "10111" => piso_seleccionado <= "100";  -- Piso 4
            when "01111" => piso_seleccionado <= "101";  -- Piso 5
            when others  => piso_seleccionado <= "000";  -- Por defecto
        end case;
    end process;
end Behavioral;
