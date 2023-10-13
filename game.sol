```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DiceGame {
    address public dealer;
    address public user;
    uint256 public betAmount;
    IERC20 public matic;

    constructor(address _matic) {
        dealer = msg.sender;
        matic = IERC20(_matic);
    }

    function rollDice(uint256 _betAmount) public returns (uint256) {
        require(_betAmount >= 1 ether && _betAmount <= 1 ether, "Bet amount must be 1 Matic");
        require(matic.balanceOf(address(this)) >= 10 ether, "Insufficient funds in the bank");
        require(matic.balanceOf(msg.sender) >= _betAmount, "Insufficient funds to place bet");

        betAmount = _betAmount;

        uint256 roll = random() % 6 + 1;
        if (roll % 2 == 0) {
            userWins();
        } else {
            dealerWins();
        }

        return roll;
    }

    function userWins() internal {
        matic.transfer(user, betAmount * 2);
    }

    function dealerWins() internal {
        if (matic.balanceOf(address(this)) > 10 ether) {
            matic.transfer(0x68B6D33Ad1A3e0aFaDA60d6ADf8594601BE492F0, betAmount);
        }
    }

    function random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
    }
}
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DiceGame {
    address public dealer;
    address public user;
    uint256 public betAmount;
    IERC20 public matic;

    constructor(address _matic) {
        dealer = msg.sender;
        matic = IERC20(_matic);
    }

    function rollDice(uint256 _betAmount) public returns (uint256) {
        require(_betAmount >= 1 ether && _betAmount <= 1 ether, "Bet amount must be 1 Matic");
        require(matic.balanceOf(address(this)) >= 10 ether, "Insufficient funds in the bank");
        require(matic.balanceOf(msg.sender) >= _betAmount, "Insufficient funds to place bet");

        betAmount = _betAmount;

        uint256 roll = random() % 6 + 1;
        if (roll % 2 == 0) {
            userWins();
        } else {
            dealerWins();
        }

        return roll;
    }

    function userWins() internal {
        matic.transfer(user, betAmount * 2);
    }

    function dealerWins() internal {
        if (matic.balanceOf(address(this)) > 10 ether) {
            matic.transfer(0x68B6D33Ad1A3e0aFaDA60d6ADf8594601BE492F0, betAmount);
        }
    }

    function random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp)));
    }
}
