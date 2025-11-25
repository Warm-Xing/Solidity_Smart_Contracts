// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//用 solidity 实现罗马数字转数整数
//题目描述在 https://leetcode.cn/problems/integer-to-roman/description/
contract RomanToIntContract {  //采用从右向左遍历的贪心算法
    function romanToInt(string memory s) public pure returns (uint256) {
        bytes memory romanBytes = bytes(s); //将输入string转换为bytes数组，允许按索引访问单个字符
        uint256 length = romanBytes.length;
        require(length > 0, "Empty string");//当条件不满足时（length=0），返回"Empty string"错误信息
        
        uint256 result = 0;
        uint256 prevValue = 0;  //记录前一个字符的数值（初始为0）
        
        for (uint256 i = length; i > 0; i--) {
            bytes1 currentChar = romanBytes[i - 1]; //从字符串末尾（索引length-1）向前遍历至开头（索引0），这是实现"左减右加"规则的关键
            uint256 currentValue = getCharValue(currentChar);
            
            if (currentValue < prevValue) { // 当前值小于前值，执行减法（如IV中的I), 用法其实是最后一个字符对应的数（或运算后的数）与前一个字符数比较，大- 小+
                result -= currentValue;
            } else {
                result += currentValue;
            }
            
            prevValue = currentValue;
        }
        
        return result;
    }
    
    function getCharValue(bytes1 char) private pure returns (uint256) {
        if (char == 'I') return 1;
        if (char == 'V') return 5;
        if (char == 'X') return 10;
        if (char == 'L') return 50;
        if (char == 'C') return 100;
        if (char == 'D') return 500;
        if (char == 'M') return 1000;
        revert("Invalid Roman character");
    }
    
}