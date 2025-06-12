# VHDL-Modules-for-Digital-Systems
This repository contains foundational VHDL modules commonly used in FPGA-based embedded and communication systems, including a D flip-flop (DFF), seven-segment display driver (sseg), and UART serial interface (uart). These modules are written in synthesizable VHDL and verified through simulation, making them ideal for digital design education, prototyping, or integration into more complex systems.
* DFF – 8-bit D Flip-Flop with Load Control
The DFF module is an 8-bit register that captures input data (D) on the rising edge of a clock (clk) when a control signal (rx_done_tick) is high. It includes an asynchronous active-low reset to clear the output (Q). This design is typically used for buffering received data in serial communication systems like UART.

Features:
8-bit synchronous data capture
Asynchronous reset
Load enable control via rx_done_tick

* sseg – Multiplexed 7-Segment Display Driver
The sseg module controls a 4-digit 7-segment display. It accepts four 4-bit hexadecimal values (hex3 to hex0) and multiplexes them onto the shared segment and anode outputs. The display scan rate is managed through an internal counter derived from the input clock.

Features:
Supports hexadecimal digits 0–F
Individual digit selection through time-multiplexing
Selectable decimal point control via dp_in
Clean architecture for FPGA display control

* uart – Full-Duplex UART Interface
The uart module provides a complete UART transmitter and receiver with optional parity checking. It is designed for RS-232 style serial communication with configurable clock and baud rates. Separate finite state machines (FSMs) control the transmit and receive logic, including start/stop bit handling, parity computation, and debouncing.

Features:
Parameterizable clock (CLK_FREQ) and baud rate (SER_FREQ)
TX and RX FSMs with parity support
Buffered data registers and handshake signaling
Input debouncing and start-bit detection for RX
Fully compatible with standard UART protocols
Ports:
tx_data, tx_req, tx_end: transmit interface
rx_data, rx_ready: receive interface
rx, tx: serial communication lines
par_en: parity enable


