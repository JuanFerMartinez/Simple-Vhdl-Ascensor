library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity botones_externos is
    Port ( botones : in STD_LOGIC_VECTOR(9 downto 0);  -- 10 botones (2 por cada piso)
           piso_llamado : out STD_LOGIC_VECTOR(2 downto 0));  -- Piso al que se debe ir
end botones_externos;

architecture Behavioral of botones_externos is
begin
    process(botones)
    begin
        -- Lógica para determinar el piso solicitado por los botones externos
        case botones is
            -- Botones de piso 1
            when "0000000001" => piso_llamado <= "001";  -- Piso 1
            when "0000000010" => piso_llamado <= "001";  -- Piso 1 (bajar desde cualquier piso superior)

            -- Botones de piso 2
            when "0000000100" => piso_llamado <= "010";  -- Piso 2
            when "0000001000" => piso_llamado <= "010";  -- Piso 2 (bajar desde cualquier piso superior)

            -- Botones de piso 3
            when "0000010000" => piso_llamado <= "011";  -- Piso 3
            when "0000100000" => piso_llamado <= "011";  -- Piso 3 (bajar desde cualquier piso superior)

            -- Botones de piso 4
            when "0001000000" => piso_llamado <= "100";  -- Piso 4
            when "0010000000" => piso_llamado <= "100";  -- Piso 4 (bajar desde cualquier piso superior)

            -- Botones de piso 5
            when "0100000000" => piso_llamado <= "101";  -- Piso 5
            when "1000000000" => piso_llamado <= "101";  -- Piso 5 (bajar desde cualquier piso superior)

            -- En caso de que no se presione ningún botón
            when others => piso_llamado <= "000";  -- Ningún piso llamado
        end case;
    end process;
end Behavioral;
