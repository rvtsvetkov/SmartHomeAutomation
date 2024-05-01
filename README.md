# Smart Home Automation

The `SmartHomeAutomation` smart contract is a robust tool for managing various household appliances and utilities through the Ethereum blockchain, deployed on the Sepolia Testnet. This contract enables the centralized control of air conditioning, lighting, television, blinds, and boiler systems within a smart home environment.

## Motivation

In the age of IoT and smart home technology, seamless integration and efficient management of home devices are crucial. The `SmartHomeAutomation` contract leverages blockchain technology to ensure security, reliability, and transparency in controlling home devices. It provides homeowners with an immutable, decentralized, and flexible system for managing their home environments, enhancing convenience and energy efficiency.

## Features

### General Device Control
- Toggle functionality for the AC, TV, boiler, lights, and blinds, allowing these devices to be turned on or off.

### Temperature and Mode Management
- Set specific temperatures for both the AC and the boiler.
- Choose from various AC modes: AUTO, HOT, COLD, DRY, and FAN.

### Lighting and Color Customization
- Adjust the RGB values of the home's LED lighting to create the desired ambiance.

### Special Modes
- **Theater Mode**: Activates a preset environment suitable for watching movies. This includes turning on the TV, turning off the lights and closing the blinds.
- **Coming Home Mode**: Prepares the home environment when the owner is expected to arrive. This involves turning on the lights, turning on the AC and opening the blinds.

### Security and Access Control
- **Access Control**: Only the owner can modify device settings, preventing unauthorized access.
- **Input Validation**: Critical inputs, like the temperature settings for the water heater, are validated to prevent unsafe operations.

## Contract Functions

### Device Toggle
- `toggleAC(bool _status)`: Turn the AC on or off.
- `toggleTV(bool _status)`: Turn the TV on or off.
- `toggleBoiler(bool _status)`: Turn the boiler on or off.
- `toggleLights(bool _status)`: Turn the lights on or off.
- `toggleBlinds(bool _status)`: Open or close the blinds.

### Temperature and Mode Settings
- `setACTemp(int _temperature)`: Set the temperature of the AC.
- `setBoilerTemp(int _temperature)`: Set the temperature of the boiler.
- `setACMode(ACMode _mode)`: Set the operating mode of the AC.

### Color Settings
- `setLEDColor(uint8 red, uint8 green, uint8 blue)`: Set the color of the LED lights using RGB values.

### Interacting with the Contract
- Use Truffle console or a frontend interface connected to Metamask to interact with the deployed contract.

#### Usage Examples

```javascript
// Turning the AC On and setting it to COLD mode
contract.methods.toggleAC(true).send({ from: owner });
contract.methods.setACMode(2).send({ from: owner });

// Activating Theater Mode
contract.methods.setTheaterMode(true).send({ from: owner });
```

## Conclusion

The `SmartHomeAutomation` smart contract stands as a testament to the potential of blockchain technology in transforming everyday life, making the management of smart home devices more secure, efficient, and user-friendly.
