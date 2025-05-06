library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity display_pisos is
    Port (
        piso : in std_logic_vector(2 downto 0);
        seg1 : out std_logic_vector(6 downto 0);
        seg2 : out std_logic_vector(6 downto 0)
    );
end display_pisos;

architecture Behavioral of display_pisos is
begin
    -- Letra 'P'
    seg1 <= "0001100"; -- P

    process(piso)
    begin
        case piso is
            when "000" => seg2 <= "1111001"; -- 1
            when "001" => seg2 <= "0100100"; -- 2
            when "010" => seg2 <= "0110000"; -- 3
            when "011" => seg2 <= "0011001"; -- 4
            when "100" => seg2 <= "0010010"; -- 5
            when others => seg2 <= "1111111";
        end case;
    end process;
end Behavioral;
