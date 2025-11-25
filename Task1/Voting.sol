//参考URL：https://github.com/XinCharlie/SoliditySmartContracts/tree/main/Task1

// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;

//创建一个名为Voting的合约，包含以下功能：
//一个mapping来存储候选人的得票数
//一个vote函数，允许用户投票给某个候选人
//一个getVotes函数，返回某个候选人的得票数
//一个resetVotes函数，重置所有候选人的得票数

contract Voting{
    mapping(string => uint256) private votes;  //只是定义一个键值对，不需要结构体
    //记录候选人名字列表，因mapping不支持遍历
    string[] private candidates;
    event Voted(address indexed voter, string candidate, uint256 newVoteCount); //indexed关键字使voter字段可被索引查询

    function Vote(string memory candidate) public{    //memory：函数执行时的临时内存（函数参数/局部变量默认位置）
        //通过votes[candidate]是否等于初始值0来判断
        if (votes[candidate] == 0) {
            candidates.push(candidate);
        }
        votes[candidate]++;
        emit Voted(msg.sender, candidate, votes[candidate]);  //触发投票事件 event
    }

    function GetVotes(string memory candidate) public view returns (uint256) {
        return votes[candidate];
    }

    function ResetVote() public{
        uint256 length = candidates.length;
        for(uint256 i = 0; i<length; i++){
            votes[candidates[i]]=0;
        }
        delete candidates;
    }
}