--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:33:03 06/12/2025
-- Design Name:   
-- Module Name:   /home/ise/verilog codes/vhdl_project/uart_tb.vhd
-- Project Name:  vhdl_project
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: uart
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
 
ENTITY uart_tb IS
END uart_tb;
 
ARCHITECTURE Behavioral OF uart_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    -- Constants
  constant CLK_PERIOD : time := 25 ns; -- 40 MHz clock

  -- DUT Signals
  signal clk       : std_logic := '0';
  signal rst       : std_logic := '0';
  signal rx        : std_logic := '1';
  signal tx        : std_logic;
  signal par_en    : std_logic := '1';
  signal tx_req    : std_logic := '0';
  signal tx_end    : std_logic;
  signal tx_data   : std_logic_vector(7 downto 0) := (others => '0');

  signal rx_ready  : std_logic;
  signal rx_data   : std_logic_vector(7 downto 0);

begin

  -- Clock generation
  clk_process : process
  begin
  while true loop
      clk <= '0';
      wait for CLK_PERIOD / 2;
      clk <= '1';
      wait for CLK_PERIOD / 2;
    end loop;
  end process;

  -- Instantiate the UART DUT
  uut: entity work.uart
    generic map (
      CLK_FREQ => 40,
      SER_FREQ => 110
    )
    port map (
	 clk        => clk,
      rst        => rst,
      rx         => rx,
      tx         => tx,
      par_en     => par_en,
      tx_req     => tx_req,
      tx_end     => tx_end,
      tx_data    => tx_data,
      rx_ready   => rx_ready,
      rx_data    => rx_data
    );

  -- Stimulus process
  stimulus : process
  begin
    -- Reset
    rst <= '1';
    wait for 100 ns;
    rst <= '0';
-- Send data 0xA5 over TX
    wait for 100 ns;
    tx_data <= "10100101";
    tx_req  <= '1';
    wait for CLK_PERIOD;
    tx_req  <= '0';

    -- Wait until transmission is complete
    wait until tx_end = '1';
    wait for 50 ns;

    -- Simulate receiving the same 0xA5 via RX line
    rx <= '1';
    wait for 1 ms; -- wait before sending

    -- Start bit
    rx <= '0';
	 wait for 9.09 ms;

    -- Data bits (LSB first: 0xA5 = 10100101)
    rx <= '1'; wait for 9.09 ms; -- bit 0
    rx <= '0'; wait for 9.09 ms; -- bit 1
    rx <= '1'; wait for 9.09 ms; -- bit 2
    rx <= '0'; wait for 9.09 ms; -- bit 3
    rx <= '0'; wait for 9.09 ms; -- bit 4
    rx <= '1'; wait for 9.09 ms; -- bit 5
    rx <= '0'; wait for 9.09 ms; -- bit 6
    rx <= '1'; wait for 9.09 ms; -- bit 7

    -- Parity bit (even parity)
    rx <= '0'; wait for 9.09 ms;

    -- Stop bit
	 rx <= '1'; wait for 9.09 ms;

    -- Wait for receive complete
    wait until rx_ready = '1';
    wait for 50 ns;

    assert rx_data = "10100101"
      report "UART RX data mismatch!" severity error;

    report "Test completed successfully.";
    wait;
  end process;

end Behavioral;
