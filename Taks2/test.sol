//任务2参考地址
//https://github.com/revado/solidity-task2/blob/main/job1/ERC20Token.sol
//https://github.com/balanceM/web3solidity/blob/main/contracts/task2/BeggingContract.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    event Deposit(address indexed sender, uint amount);
    event Withdraw(address indexed receiver, uint amount);

    function deposit() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint amount) external {
        payable(msg.sender).transfer(amount);
        emit Withdraw(msg.sender, amount);
    }
}