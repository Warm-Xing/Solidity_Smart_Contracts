//反转字符串 (Reverse String)
//题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"
//反转字符串需要手动实现，因为 Solidity 没有内置的字符串反转函数
// SPDX-License-Identifier: MIT
pragma solidity^0.8.0;
contract StringReverser {
    /**
     * @dev 反转输入字符串
     * @param input 待反转的字符串
     * @return 反转后的字符串
     */
    function reverseString(string memory input) public pure returns (string memory) {
        // 将字符串转换为字节数组（Solidity中字符串不可直接修改）
        bytes memory inputBytes = bytes(input);
        uint256 length = inputBytes.length;
        
        // 空字符串或单字符直接返回
        if (length <= 1) {
            return input;
        }
        
        // 双指针交换字符（从两端向中间靠拢）
        for (uint256 i = 0; i < length / 2; i++) {
            bytes1 temp = inputBytes[i];
            inputBytes[i] = inputBytes[length - 1 - i];
            inputBytes[length - 1 - i] = temp;
        }
        
        // 将字节数组转换回字符串
        return string(inputBytes);
    }
}