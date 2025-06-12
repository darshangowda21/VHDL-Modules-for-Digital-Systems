--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:33:19 06/11/2025
-- Design Name:   
-- Module Name:   /home/ise/verilog codes/VHDL1/tb_DFF.vhd
-- Project Name:  VHDL1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: DFF
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_DFF IS
END tb_DFF;
 
ARCHITECTURE behavior OF tb_DFF IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DFF
    PORT(
         D : IN  std_logic_vector(7 downto 0);
         Q : OUT  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         rx_done_tick : IN  std_logic
        );
    END COMPONENT;
    

  -- Inputs
   signal D : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal rx_done_tick : std_logic := '0';

   -- Output
   signal Q : std_logic_vector(7 downto 0);

   -- Clock period definition
   constant clk_period : time := 10 ns;

BEGIN
-- Instantiate the Unit Under Test (UUT)
   uut: DFF PORT MAP (
          D => D,
          Q => Q,
          clk => clk,
          reset => reset,
          rx_done_tick => rx_done_tick
        );

   -- Clock generation
   clk_process : process
   begin
      while now < 300 ns loop
         clk <= '0';
			wait for clk_period/2;
         clk <= '1';
         wait for clk_period/2;
      end loop;
      wait;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
      -- Apply reset
      reset <= '0';
      wait for 20 ns;
      reset <= '1';  -- Deassert reset
      
      wait for clk_period;
		-- Test 1: Load data into flip-flop
      D <= "10101010";
      rx_done_tick <= '1';
      wait for clk_period;
      rx_done_tick <= '0';

      wait for clk_period * 2;

      -- Test 2: Change input but no tick, Q should not change
      D <= "11110000";
      wait for clk_period;

      -- Test 3: Apply tick again to latch new value
      rx_done_tick <= '1';
      wait for clk_period;
      rx_done_tick <= '0';

      wait for clk_period * 2;
		 -- Apply reset again and test output clearing
      reset <= '0';
      wait for clk_period;
      reset <= '1';

      wait;
   end process;

END;
