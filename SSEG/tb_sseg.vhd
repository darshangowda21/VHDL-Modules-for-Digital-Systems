--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:17:10 06/12/2025
-- Design Name:   
-- Module Name:   /home/ise/verilog codes/vhdl_project/tb_sseg.vhd
-- Project Name:  vhdl_project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sseg
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_sseg IS
END tb_sseg;
 
ARCHITECTURE behavior OF tb_sseg IS 
 
        -- Component declaration of the Unit Under Test (UUT)
    component sseg
        port (
            clk     : in  std_logic;
            reset   : in  std_logic;
            dp_in   : in  std_logic_vector(3 downto 0);
            hex3    : in  std_logic_vector(3 downto 0);
            hex2    : in  std_logic_vector(3 downto 0);
            hex1    : in  std_logic_vector(3 downto 0);
 hex0    : in  std_logic_vector(3 downto 0);
            an      : out std_logic_vector(3 downto 0);
            seg     : out std_logic_vector(0 to 7)
        );
    end component;

    -- Signals for testing
    signal clk     : std_logic := '0';
    signal reset   : std_logic := '0';
	 signal dp_in   : std_logic_vector(3 downto 0) := "0000";
    signal hex3    : std_logic_vector(3 downto 0) := "0000";
    signal hex2    : std_logic_vector(3 downto 0) := "0000";
    signal hex1    : std_logic_vector(3 downto 0) := "0000";
    signal hex0    : std_logic_vector(3 downto 0) := "0000";
    signal an      : std_logic_vector(3 downto 0);
    signal seg     : std_logic_vector(0 to 7);
constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test
    uut: sseg port map (
        clk     => clk,
        reset   => reset,
        dp_in   => dp_in,
        hex3    => hex3,
		  hex2    => hex2,
        hex1    => hex1,
        hex0    => hex0,
        an      => an,
        seg     => seg
    );

    -- Clock generation
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
				 end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Apply reset
        reset <= '0';
        wait for 20 ns;
        reset <= '1';
		  -- Apply test values
        dp_in <= "1010";        -- Decimal points enabled on hex0 and hex2
        hex0 <= "0001";         -- Display "1"
        hex1 <= "0010";         -- Display "2"
        hex2 <= "0011";         -- Display "3"
        hex3 <= "0100";         -- Display "4"

        wait for 200 us;        -- Let the display cycle through values
        wait;
    end process;

end behavior;