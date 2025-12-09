//参考链接https://github.com/balanceM/web3solidity/blob/main/contracts/task2/BeggingContract.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;
contract BeggingContract {
    address public owner;
    mapping(address => uint256) public donatorTotal;
    event Donation(address donator, uint256 value);
    uint256 top3MinAmount; // 进入前3的最少金额
    uint256 top3MinIndex; // 进入前3的最少金额的对应地址索引
    address[3] public top3Donators; // 捐赠金额最多的前3个地址

    constructor() {
        owner = msg.sender;  // 部署者成为初始所有者
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "you are not owner");// 权限检查
        _;  // 执行被修饰的函数体
    }

    uint256 public constant TARGET_TIMESTAMP = 1735702861;
    modifier timeLimit() {
        require(block.timestamp > TARGET_TIMESTAMP, "donate start after 2025-01-01 01:01:01 UTC");
        _;
    }

    function donate() external payable timeLimit {
        require(msg.value > 0, "value must be greater than 0");

        emit Donation(msg.sender, msg.value);
        donatorTotal[msg.sender] += msg.value;

        uint256 curAmount;
        address curDonator;
        if(donatorTotal[msg.sender] > top3MinAmount) {// 捐赠者还没达到3个执行
            bool CountGreater3 = true;
            for (uint256 i=0; i < 3; i++) {
                if (top3Donators[i] == address(0)) { 
                    CountGreater3 = false;

                    top3Donators[i] = msg.sender;
                    if(i != 2) break; // 后续还会有0地址时，3个集齐后开始设定top3MinAmount是多少

                    // 最后一位是0地址时，设置当前捐赠者时
                    top3MinAmount = donatorTotal[top3Donators[0]];  // 初始化为第1名金额
                    for(uint256 j=1; j<3; j++) {
                        curDonator = top3Donators[j];
                        curAmount = donatorTotal[curDonator];
                        if (top3MinAmount > curAmount) {
                            top3MinAmount = curAmount;
                            top3MinIndex = j;
                        }
                    }
                }
            }

            if (CountGreater3) {// 捐赠者达到3个,执行
                top3Donators[top3MinIndex] = msg.sender;
                top3MinAmount = donatorTotal[msg.sender];
                for (uint256 i=0; i < 3; i++) {
                    if(i == top3MinIndex) continue; //回头继续执行循环，下面不执行

                    curAmount = donatorTotal[top3Donators[i]];
                    if(top3MinAmount > curAmount) {
                        top3MinAmount = curAmount;
                        top3MinIndex = i;
                    }
                }
            }
        }
    }

    function withdraw() external onlyOwner {
        payable(owner).transfer(address(this).balance);// 仅所有者可提款
    }

    function getDonation(address donator) external view returns(uint256) {
        require(donator != address(0), "donator is a 0 address");//防止查询0地址的捐赠记录

        return donatorTotal[donator];
    }
}

//你的钱包 → 点击donate → 合约地址（临时存储） → 所有者调用withdraw → 所有者钱包