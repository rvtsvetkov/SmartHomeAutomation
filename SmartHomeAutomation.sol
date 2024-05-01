// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

contract SmartHomeAutomation {

    struct RGB {
        uint8 red;
        uint8 green;
        uint8 blue;
    }

    enum ACMode {
        AUTO,
        HOT,
        COLD,
        DRY,
        FAN
    }

    address public owner;
    bool    public isACOn;
    bool    public isTVOn;
    bool    public isBoilerOn;
    bool    public areLightsOn;
    bool    public areBlindsClosed;
    int     public acTemp;          /* In Celsius */
    int     public waterTemp;       /* In Celsius */
    ACMode  public currentACMode;
    RGB     public ledColor;

    event DeviceStatusChanged(string device, bool status);
    event ACTempSet(int temperature);
    event BoilerTempSet(int temperature);
    event ACModeChanged(ACMode mode);
    event LEDColorSet(uint8 red, uint8 green, uint8 blue);
    event TheaterModeActivated(bool status);
    event ComingHomeModeActivated(bool status);

    constructor() {
        owner           = msg.sender;
        acTemp          = 20;
        waterTemp       = 50;
        currentACMode   = ACMode.AUTO;
        ledColor        = RGB(255, 255, 255); /* White */
    }

    modifier onlyOwner() {
        require(msg.sender == owner,
                "Only the owner is allowed to perform this action.");
        _;
    }

    /*
     * Smart devices controls
     */

    function toggleAC(bool _status) public onlyOwner {
        isACOn = _status;
        emit DeviceStatusChanged("AC", _status);
    }

    function toggleTV(bool _status) public onlyOwner {
        isTVOn = _status;
        emit DeviceStatusChanged("TV", _status);
    }

    function toggleBoiler(bool _status) public onlyOwner {
        isBoilerOn = _status;
        emit DeviceStatusChanged("Boiler", _status);
    }

    function toggleLights(bool _status) public onlyOwner {
        areLightsOn = _status;
        emit DeviceStatusChanged("Lights", _status);
    }

    function toggleBlinds(bool _status) public onlyOwner {
        areBlindsClosed = _status;
        emit DeviceStatusChanged("Blinds", _status);
    }

    function setACTemp(int _temp) public onlyOwner {
        require(_temp >= 15, "Temperature is too low.");
        require(_temp <= 35, "Temperature is too high.");
        acTemp = _temp;
        emit ACTempSet(_temp);
    }

    function setBoilerTemp(int _temp) public onlyOwner {
        require(_temp >= 30, "Temperature is too low.");
        require(_temp <= 80, "Temperature is too high.");
        waterTemp = _temp;
        emit BoilerTempSet(_temp);
    }

    function setACMode(ACMode _mode) public onlyOwner {
        require(isACOn == true, "AC is off.");
        currentACMode = _mode;
        emit ACModeChanged(_mode);
    }

    function setLEDColor(uint8 _red, uint8 _green, uint8 _blue) public onlyOwner {
        require(areLightsOn == true, "Lights are off.");
        ledColor = RGB(_red, _green, _blue);
        emit LEDColorSet(_red, _green, _blue);
    }

    /*
     * Custom modes
     */

    function setTheaterMode(bool _activate) public onlyOwner {
        if (_activate) {
            isTVOn          = true;
            areLightsOn     = false;
            areBlindsClosed = true;

            emit DeviceStatusChanged("TV",      true);
            emit DeviceStatusChanged("Lights",  false);
            emit DeviceStatusChanged("Blinds",  true);

            emit TheaterModeActivated(true);
        } else {
            isTVOn          = false;
            areLightsOn     = true;
            areBlindsClosed = false;

            emit DeviceStatusChanged("TV",      false);
            emit DeviceStatusChanged("Lights",  true);
            emit DeviceStatusChanged("Blinds",  false);

            emit TheaterModeActivated(false);
        }
    }

    function setComingHomeMode(bool _activate) public onlyOwner {
        if (_activate) {
            isACOn          = true;
            areLightsOn     = true;
            areBlindsClosed = false;

            emit DeviceStatusChanged("AC",      true);
            emit DeviceStatusChanged("Lights",  true);
            emit DeviceStatusChanged("Blinds",  false);

            emit ComingHomeModeActivated(true);
        } else {
            isACOn          = false;
            areLightsOn     = false;
            areBlindsClosed = true;

            emit DeviceStatusChanged("AC",      false);
            emit DeviceStatusChanged("Lights",  false);
            emit DeviceStatusChanged("Blinds",  true);

            emit ComingHomeModeActivated(false);
        }
    }
}

