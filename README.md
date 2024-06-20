# Snake Game on Arty Z7 with Pmod OLED Display

## Introduction

This project involves the development of a classic snake game implemented on the Arty Z7 FPGA board, utilizing a Pmod OLED display for visual output. The game is designed to be played using the onboard switches and buttons of the Arty Z7.

## Project Components

- **Arty Z7 FPGA Board**: Main platform for running the Verilog code that implements the game logic and display interface.
- **Pmod OLED**: Used as the display output for the game, featuring a resolution of 96 x 64 pixels.

## Setup and Configuration

### Hardware Setup

1. Connect the Pmod OLED to the appropriate Pmod connector on the Arty Z7 board.
2. Ensure that power and programming cables are securely connected.

### Software and Programming

The project uses Verilog to program the FPGA. The Verilog files control the game logic, user input, and output to the OLED display.

## Credits and Acknowledgements

Special thanks to Jonathan Chua for his assistance in the development of this project.

## Future Enhancements

- Introduce sound when snake hit the wall, eat the apple
- Add scoring and level up mechanisms.
- Introduce more complex obstacles and power-ups.

## Conclusion

This project showcases the capabilities of the Arty Z7 FPGA board in handling real-time video game logic and interfacing with peripheral modules like the Pmod OLED. It provides a foundation for more complex FPGA-based gaming projects.
