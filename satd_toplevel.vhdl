library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity satd_toplevel is
    generic (
        N : positive:= 8 -- número de bits das entradas e da saída
    );
    port(

        clk : in std_logic;
        rst : in std_logic;

        enable    : in  std_logic;
        direction_transpose_buffer : in  std_logic;

        input01,input02,input11,input12,input21,input22,input31,input32, 
        input41,input42,input51,input52,input61,input62,input71,input72: in std_logic_vector(N-1 downto 0);

        done: out std_logic;

        satd : out std_logic_vector(N+11 downto 0)
    );
end entity satd_toplevel;

architecture topLeveling of satd_toplevel is
    signal enable_inputs, reset_transpose_buffer, enable_transpose_buffer, change_transpose_buffer_direction, reset_psatd, enable_psatd, reset_satd, enable_satd  : std_logic;
    
--    component satd_bc
--        port(
--            clock               : in  std_logic;
--            reset               : in  std_logic;
--            enable              : in  std_logic;
--            enable_inputs       : out std_logic;
--            reset_tb            : out std_logic;
--            enable_tb           : out std_logic;
--            change_tb_direction : out std_logic;
--            reset_psatd         : out std_logic;
--            enable_psatd        : out std_logic;
--            reset_satd          : out std_logic;
--            enable_satd         : out std_logic;
--            done                : out std_logic
--        );
--    end component satd_bc;
--
--    component satd_bo
--        generic(N : positive := 8);
--        port(
--            clk                                                                                                                                            : in  std_logic;
--            rst                                                                                                                                            : in  std_logic;
--            input01, input02, input11, input12, input21, input22, input31, input32, input41, input42, input51, input52, input61, input62, input71, input72 : in  unsigned(N-1 downto 0);
--            enable_inputs                                                                                                                                  : in  std_logic;
--            enable_tb                                                                                                                                      : in  std_logic;
--            change_tb_direction                                                                                                                            : in  std_logic;
--            satd_result                                                                                                                                    : out unsigned(16 downto 0)
--        );
--    end component satd_bo;

    

begin

    
    satd_bc_inst : entity work.satd_bc(behavior)
        port map(
            clock               => clk,
            reset               => rst,
            enable              => enable,
            enable_inputs       => enable_inputs,
            reset_tb            => reset_transpose_buffer,
            enable_tb           => enable_transpose_buffer,
            change_tb_direction => change_transpose_buffer_direction,
            reset_psatd         => reset_psatd,
            enable_psatd        => enable_psatd,
            reset_satd          => reset_satd,
            enable_satd         => enable_satd,
            done                => done
        );

    satd_bo_inst : entity work.satd_bo(structure)
        generic map(
            N => N
        )
        port map(
            clk             => clk,
            rst             => rst,
            rst_tb          => reset_transpose_buffer,
            rst_psatd       => reset_psatd,
            rst_satd        => reset_satd,

            enable_inputs       => enable_inputs,
            enable_tb           => enable_transpose_buffer,
            enable_psatd        => enable_psatd,
            enable_satd         => enable_satd,
				
			change_tb_direction => change_transpose_buffer_direction,

            satd_result => satd,

            input01 => input01,
            input02 => input02,
            input11 => input11,
            input12 => input12,
            input21 => input21,
            input22 => input22,
            input31 => input31,
            input32 => input32,
            input41 => input41,
            input42 => input42,
            input51 => input51,
            input52 => input52,
            input61 => input61,
            input62 => input62,
            input71 => input71,
            input72 => input72
        );
    
    
end architecture topLeveling;

