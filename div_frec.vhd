library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_frec is
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        clk_4s  : out STD_LOGIC;
        clk_5s  : out STD_LOGIC
    );
end div_frec;

architecture Behavioral of div_frec is
    signal count_4s : INTEGER := 0;
    signal count_5s : INTEGER := 0;
    signal clk_4s_int : STD_LOGIC := '0';
    signal clk_5s_int : STD_LOGIC := '0';
begin
    process(clk, rst)
    begin
        if rst = '1' then
            count_4s <= 0;
            count_5s <= 0;
            clk_4s_int <= '0';
            clk_5s_int <= '0';
        elsif rising_edge(clk) then
            -- Divisor para 4 segundos
            if count_4s < 200000000 then  -- 4s @ 50MHz
                count_4s <= count_4s + 1;
            else
                count_4s <= 0;
                clk_4s_int <= NOT clk_4s_int;
            end if;

            -- Divisor para 5 segundos
            if count_5s < 250000000 then  -- 5s @ 50MHz
                count_5s <= count_5s + 1;
            else
                count_5s <= 0;
                clk_5s_int <= NOT clk_5s_int;
            end if;
        end if;
    end process;

    clk_4s <= clk_4s_int;
    clk_5s <= clk_5s_int;

end Behavioral;
