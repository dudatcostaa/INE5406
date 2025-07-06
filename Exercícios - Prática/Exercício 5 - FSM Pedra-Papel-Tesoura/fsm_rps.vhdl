LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY fsm_rps IS
    PORT (
        clk : IN std_logic;
        rst_a : IN std_logic;
        ok : IN std_logic;
        play : IN std_logic_vector(1 DOWNTO 0);
        winner : OUT std_logic_vector(1 DOWNTO 0)
    );
END fsm_rps;

ARCHITECTURE arch OF fsm_rps IS

    type estado is (wait_p1, sc_wait_p2, ro_wait_p2, pa_wait_p2, p1_wins, draw, p2_wins);
    signal ea : estado;
    
BEGIN 
     ControleDeEstados : process (clk, rst_a)
        BEGIN
            if rst_a = '1' then
            ea <= wait_p1;
            winner <= "00";
            
            elsif (rising_edge(clk)) then
                case ea is
                when wait_p1 =>
                if ok = '0' then
                    ea <= wait_p1;
                elsif (ok = '1' and play = "01") then
                    ea <= sc_wait_p2;
                elsif (ok = '1' and play = "10") then
                    ea <= ro_wait_p2;
                elsif (ok = '1' and play = "11") then
                    ea <= pa_wait_p2;
                else
                    ea <= wait_p1;
                end if;
                winner <= "00";
                
                when sc_wait_p2 =>
                if ok = '0' then
                    ea <= sc_wait_p2;
                    winner <= "00";
                elsif (ok = '1' and play = "01") then
                    ea <= draw;
                    winner <= "11";
                elsif (ok = '1' and play = "10") then
                    ea <= p2_wins;
                    winner <= "10";
                elsif (ok = '1' and play = "11") then
                    ea <= p1_wins;
                    winner <= "01";
                else
                    ea <= sc_wait_p2;
                    winner <= "00";
                end if;
                
                when ro_wait_p2 =>
                if ok = '0' then
                    ea <= ro_wait_p2;
                    winner <= "00";
                elsif (ok = '1' and play = "01") then
                    ea <= p1_wins;
                    winner <= "01";
                elsif (ok = '1' and play = "10") then
                    ea <= draw;
                    winner <= "11";
                elsif (ok = '1' and play = "11") then
                    ea <= p2_wins;
                    winner <= "10";
                else
                    ea <= ro_wait_p2;
                    winner <= "00";
                end if;
                
                when pa_wait_p2 =>
                if ok = '0' then
                    ea <= pa_wait_p2;
                    winner <= "00";
                elsif (ok = '1' and play = "01") then
                    ea <= p2_wins;
                    winner <= "10";
                elsif (ok = '1' and play = "10") then
                    ea <= p1_wins;
                    winner <= "01";
                elsif (ok = '1' and play = "11") then
                    ea <= draw;
                    winner <= "11";
                else
                    ea <= pa_wait_p2;
                    winner <= "00";
                end if;
                
                when p1_wins =>
                    if ok = '0' then
                        winner <= "01";
                        ea <= p1_wins; --fica no mesmo estado
                    else 
                        winner <= "00";
                        ea <= wait_p1; --reinicia
                    end if;
                    
                when p2_wins =>
                    if ok = '0' then
                        winner <= "10";
                        ea <= p2_wins;
                    else
                        winner <= "00";
                        ea <= wait_p1;
                    end if;
                    
                when draw =>
                    if ok = '0' then
                        winner <= "11";
                        ea <= draw;
                    else
                        winner <= "00";
                        ea <= wait_p1;
                    end if;
                    
                end case;
            end if;
        end process;
                
END arch;           
                