library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.image_operations.operation_type;

entity processingElement is
    generic(N: positive := 8);
    port(
        operation : in operation_type;
        offset    : in  unsigned(N-1 downto 0);
        sample    : in  unsigned(N-1 downto 0);
        result    : out unsigned(N-1 downto 0)
    );
end processingElement;

architecture mixed of processingElement is
	signal add : std_logic;
	signal clipped : unsigned (sample'range);
	signal thresholded: unsigned (sample'range);
	constant threshold_value : integer := 2**(thresholded'high);
begin

	ADSC: entity work.addSubClip(arch)
			generic map (N => N)
			port map (inputA=>sample, inputB=>offset, add=>add, clipped=>clipped);

	-- Cálculo combinacional da operação de limiar. 
	thresholded <= to_unsigned(0, thresholded'length) when (to_integer(sample) < threshold_value) 
	          else to_unsigned(2**(thresholded'length)-1, thresholded'length);

	
	process(all) begin
		case(operation) is
			when PASSTHROUGH =>
				add <= '0';
				result <= sample;
			when THRESHOLD => 
				add <= '0';
				result <= thresholded ;
			when ADD_OFFSET =>
			    add <= '1' ;
			    result <= clipped ;
			when SUB_OFFSET =>
			    add <= '0' ;
			    result <= clipped ;
		end case;
	end process;

end mixed;

