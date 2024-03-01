// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

enum YieldMode {
    AUTOMATIC,
    VOID,
    CLAIMABLE
}

enum GasMode {
    VOID,
    CLAIMABLE 
}

interface IBlast{
    // configure
    function configureContract(address contractAddress, YieldMode _yield, GasMode gasMode, address governor) external;
    function configure(YieldMode _yield, GasMode gasMode, address governor) external;

    // base configuration options
    function configureClaimableYield() external;
    function configureClaimableYieldOnBehalf(address contractAddress) external;
    function configureAutomaticYield() external;
    function configureAutomaticYieldOnBehalf(address contractAddress) external;
    function configureVoidYield() external;
    function configureVoidYieldOnBehalf(address contractAddress) external;
    function configureClaimableGas() external;
    function configureClaimableGasOnBehalf(address contractAddress) external;
    function configureVoidGas() external;
    function configureVoidGasOnBehalf(address contractAddress) external;
    function configureGovernor(address _governor) external;
    function configureGovernorOnBehalf(address _newGovernor, address contractAddress) external;

    // claim yield
    function claimYield(address contractAddress, address recipientOfYield, uint256 amount) external returns (uint256);
    function claimAllYield(address contractAddress, address recipientOfYield) external returns (uint256);

    // claim gas
    function claimAllGas(address contractAddress, address recipientOfGas) external returns (uint256);
    function claimGasAtMinClaimRate(address contractAddress, address recipientOfGas, uint256 minClaimRateBips) external returns (uint256);
    function claimMaxGas(address contractAddress, address recipientOfGas) external returns (uint256);
    function claimGas(address contractAddress, address recipientOfGas, uint256 gasToClaim, uint256 gasSecondsToConsume) external returns (uint256);

    // read functions
    function readClaimableYield(address contractAddress) external view returns (uint256);
    function readYieldConfiguration(address contractAddress) external view returns (uint8);
    function readGasParams(address contractAddress) external view returns (uint256 etherSeconds, uint256 etherBalance, uint256 lastUpdated, GasMode);
}

contract RockPaperScissors{

    //modifier onlyOwner
    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    //Owner's address
    address owner; 

    //event to track result of game.
    event Gamed(address player, uint256 amount, uint256 option, uint256 contractOption, int8 result); 

    //payable = user может заплатить в BNB (главная монета в блокчейне)
    //in Constructor we assign owner's address;
    constructor() payable {
        owner = msg.sender;
        IBlast(0x4300000000000000000000000000000000000002).configureAutomaticYield();
    }

    //function that asks for 0, 1 or 2 and returns if you win, lose or draw
    function selectRPS(uint8 _option) public payable returns (int8){ //view, pure = gassless 
        require(_option<3, "Please choose a rock, scissors or paper");
        require(msg.value>0, "Please add your bet"); //WEI smallest unit ETH 
        //1,000,000,000,000,000,000 WEI = 1 ETH 
        require(msg.value*2 <= address(this).balance, "Contract balance is insuffieient ");

        //PseudoRandom and check with _option 
        uint contractOption = block.timestamp*block.gaslimit%3; 
        int8 result = 0;
if (_option == contractOption) {
    payable(msg.sender).transfer(msg.value/2);
                } else if ((_option == 0 && contractOption == 1) ||
        (_option == 2 && contractOption == 0) ||
                (_option == 1 && contractOption == 2)) {
            result = 1;
        } else {
        result = -1;
        }

        //Emiting event of Coin Flip
        emit Gamed(msg.sender, msg.value, _option, contractOption, result);

        //If user wins he doubles his stake
        if (result == 1){
            payable(msg.sender).transfer(msg.value*2);
        }
        // Returning the result.
        return result;
        
    }

    //Owner can withdraw BNB amount
    function withdraw() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }

receive() external payable {
    // Пустая функция, необходима для возможности отправки ETH на адрес контракта
}
}