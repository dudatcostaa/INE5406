library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Multiplexador 2:1 com entradas e saída de N bits.

entity mux_2to1 is
	generic(
		N : positive -- número de bits das entradas e da saída
	);
	port(
		sel        : in  std_logic;
		in_0, in_1 : in  signed(N - 1 downto 0); 
		y          : out signed(N - 1 downto 0)  
	);
end mux_2to1;
architecture behavior of mux_2to1 is
begin
with sel select
y <= in_0 when '0',
	in_1 when others;
end architecture behavior;
