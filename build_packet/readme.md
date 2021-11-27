# Matlab packet building

This is the implementation of packet building in Wi-attack.

A WiFi symbol corresponding to each BLE symbol (`0000`, `0001`, ... , `1111`) is first input to generate a phase template using `buildTemplate.m`. Then the emulated BLE packet can be built by using `emuphase.m`. The complex file can then be transmitted using a USRP N210.
