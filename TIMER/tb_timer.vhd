--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:24:10 06/11/2025
-- Design Name:   
-- Module Name:   /home/ise/verilog codes/VHDL0/tb_timer.vhd
-- Project Name:  VHDL0
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: timer
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
use ieee.numeric_std.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_timer IS
END tb_timer;
 
ARCHITECTURE behavior OF tb_timer IS 
 
   -- Constants
    constant N : integer := 8;  -- Use small width for easy simulation

    -- Signals to connect to DUT
    signal clk   : std_logic := '0';
    signal reset : std_logic := '1';
    signal Q     : std_logic_vector(N-1 downto 0);

    -- Clock period
	 constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.timer
        generic map (N => N)
        port map (
            clk   => clk,
            reset => reset,
            Q     => Q
        );
-- Clock generation
    clk_process : process
    begin
        while now < 300 ns loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
	  -- Initial reset active
        reset <= '0';
        wait for 20 ns;

        -- Deactivate reset
        reset <= '1';
        wait for 100 ns;

        -- Reset again mid-count
        reset <= '0';
        wait for 20 ns;
        reset <= '1';

        -- Run further
        wait for 100 ns;

        wait;
    end process;

end behavior;
