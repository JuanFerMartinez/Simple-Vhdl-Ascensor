library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity conteo_personas is
    Port (
        dip_switch : in STD_LOGIC_VECTOR(10 downto 0);
        sobrepeso  : out STD_LOGIC
    );
end conteo_personas;

architecture Behavioral of conteo_personas is
begin
    process(dip_switch)
        variable contador : integer := 0;
    begin
        contador := 0;  -- reiniciar contador
        for i in dip_switch'range loop
            if dip_switch(i) = '1' then
                contador := contador + 1;
            end if;
        end loop;

        if contador > 10 then
            sobrepeso <= '1';
        else
            sobrepeso <= '0';
        end if;
    end process;
end Behavioral;
