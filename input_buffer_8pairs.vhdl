library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity input_buffer_8pairs is
  generic (
    N : integer := 8
  );
  port (
    clk  : in  std_logic;
    rst  : in  std_logic;
    enable : in  std_logic;

    in_01  : in  std_logic_vector(N-1 downto 0);
    in_02  : in  std_logic_vector(N-1 downto 0);
    in_11  : in  std_logic_vector(N-1 downto 0);
    in_12  : in  std_logic_vector(N-1 downto 0);
    in_21  : in  std_logic_vector(N-1 downto 0);
    in_22  : in  std_logic_vector(N-1 downto 0);
    in_31  : in  std_logic_vector(N-1 downto 0);
    in_32  : in  std_logic_vector(N-1 downto 0);
    in_41  : in  std_logic_vector(N-1 downto 0);
    in_42  : in  std_logic_vector(N-1 downto 0);
    in_51 : in  std_logic_vector(N-1 downto 0);
    in_52 : in  std_logic_vector(N-1 downto 0);
    in_61 : in  std_logic_vector(N-1 downto 0);
    in_62 : in  std_logic_vector(N-1 downto 0);
    in_71 : in  std_logic_vector(N-1 downto 0);
    in_72 : in  std_logic_vector(N-1 downto 0);

    out_01  : out unsigned(N-1 downto 0);
    out_02  : out unsigned(N-1 downto 0);
    out_11  : out unsigned(N-1 downto 0);
    out_12  : out unsigned(N-1 downto 0);
    out_21  : out unsigned(N-1 downto 0);
    out_22  : out unsigned(N-1 downto 0);
    out_31  : out unsigned(N-1 downto 0);
    out_32  : out unsigned(N-1 downto 0);
    out_41  : out unsigned(N-1 downto 0);
    out_42  : out unsigned(N-1 downto 0);
    out_51  : out unsigned(N-1 downto 0);
    out_52  : out unsigned(N-1 downto 0);
    out_61  : out unsigned(N-1 downto 0);
    out_62  : out unsigned(N-1 downto 0);
    out_71  : out unsigned(N-1 downto 0);
    out_72  : out unsigned(N-1 downto 0)
  );
end entity;

architecture rtl of input_buffer_8pairs is

  signal r_out_0  : unsigned(N-1 downto 0);
  signal r_out_1  : unsigned(N-1 downto 0);
  signal r_out_2  : unsigned(N-1 downto 0);
  signal r_out_3  : unsigned(N-1 downto 0);
  signal r_out_4  : unsigned(N-1 downto 0);
  signal r_out_5  : unsigned(N-1 downto 0);
  signal r_out_6  : unsigned(N-1 downto 0);
  signal r_out_7  : unsigned(N-1 downto 0);
  signal r_out_8  : unsigned(N-1 downto 0);
  signal r_out_9  : unsigned(N-1 downto 0);
  signal r_out_10 : unsigned(N-1 downto 0);
  signal r_out_11 : unsigned(N-1 downto 0);
  signal r_out_12 : unsigned(N-1 downto 0);
  signal r_out_13 : unsigned(N-1 downto 0);
  signal r_out_14 : unsigned(N-1 downto 0);
  signal r_out_15 : unsigned(N-1 downto 0);

begin

  out_01 <= r_out_0;
  out_02 <= r_out_1;
  out_11 <= r_out_2;
  out_12 <= r_out_3;
  out_21 <= r_out_4;
  out_22 <= r_out_5;
  out_31 <= r_out_6;
  out_32 <= r_out_7;
  out_41 <= r_out_8;
  out_42 <= r_out_9;
  out_51 <= r_out_10;
  out_52 <= r_out_11;
  out_61 <= r_out_12;
  out_62 <= r_out_13;
  out_71 <= r_out_14;
  out_72 <= r_out_15;

  process(clk, rst)
  begin
    if rst = '1' then
      r_out_0  <= (others => '0');
      r_out_1  <= (others => '0');
      r_out_2  <= (others => '0');
      r_out_3  <= (others => '0');
      r_out_4  <= (others => '0');
      r_out_5  <= (others => '0');
      r_out_6  <= (others => '0');
      r_out_7  <= (others => '0');
      r_out_8  <= (others => '0');
      r_out_9  <= (others => '0');
      r_out_10 <= (others => '0');
      r_out_11 <= (others => '0');
      r_out_12 <= (others => '0');
      r_out_13 <= (others => '0');
      r_out_14 <= (others => '0');
      r_out_15 <= (others => '0');
    elsif rising_edge(clk) then
      if enable = '1' then
        r_out_0  <= unsigned(in_01);
        r_out_1  <= unsigned(in_02);
        r_out_2  <= unsigned(in_11);
        r_out_3  <= unsigned(in_12);
        r_out_4  <= unsigned(in_21);
        r_out_5  <= unsigned(in_22);
        r_out_6  <= unsigned(in_31);
        r_out_7  <= unsigned(in_32);
        r_out_8  <= unsigned(in_41);
        r_out_9  <= unsigned(in_42);
        r_out_10 <= unsigned(in_51);
        r_out_11 <= unsigned(in_52);
        r_out_12 <= unsigned(in_61);
        r_out_13 <= unsigned(in_62);
        r_out_14 <= unsigned(in_71);
        r_out_15 <= unsigned(in_72);
      end if;
    end if;
  end process;

end architecture;
