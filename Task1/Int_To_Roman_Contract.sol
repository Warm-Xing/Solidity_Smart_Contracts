// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//用 solidity 实现整数转罗马数字
//题目描述在 https://leetcode.cn/problems/roman-to-integer/description/3.
contract IntegerToRoman {
    struct RomanSymbol {
        uint256 value;
        string symbol;
    }
    
    RomanSymbol[] private romanSymbols;
    
    constructor() {  //执行时机：仅在合约部署到区块链时自动执行一次
        initializeRomanSymbols();
    }
    
    function initializeRomanSymbols() private {
        romanSymbols.push(RomanSymbol(1000, "M"));
        romanSymbols.push(RomanSymbol(900, "CM"));
        romanSymbols.push(RomanSymbol(500, "D"));
        romanSymbols.push(RomanSymbol(400, "CD"));
        romanSymbols.push(RomanSymbol(100, "C"));
        romanSymbols.push(RomanSymbol(90, "XC"));
        romanSymbols.push(RomanSymbol(50, "L"));
        romanSymbols.push(RomanSymbol(40, "XL"));
        romanSymbols.push(RomanSymbol(10, "X"));
        romanSymbols.push(RomanSymbol(9, "IX"));
        romanSymbols.push(RomanSymbol(5, "V"));
        romanSymbols.push(RomanSymbol(4, "IV"));
        romanSymbols.push(RomanSymbol(1, "I"));
    }
    

    function intToRoman(uint256 num) public view returns (string memory) {
        require(num > 0 && num < 4000, "Number must be between 1 and 3999");
        
        string memory result = "";
        uint256 remaining = num;
        
        for (uint256 i = 0; i < romanSymbols.length; i++) {  //外层循环遍历符号数组（从大到小）
            RomanSymbol memory symbol = romanSymbols[i];
            
            while (remaining >= symbol.value) {//（贪婪匹配）
                result = string(abi.encodePacked(result, symbol.symbol)); //abi.encodePacked高效拼接字符串结果，最大会出现MMM的拼接
                remaining -= symbol.value;
            }
            
            if (remaining == 0) {
                break;
            }
        }
        
        return result;
    }
    
}