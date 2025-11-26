// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//输入数组比较[1,4,7]和[2,5,8]
contract ArrayMerger {
    // 合并两个有序数组（升序）
    function mergeSortedArrays(uint[] memory arr1, uint[] memory arr2) public pure returns (uint[] memory) {
        uint i = 0; // arr1指针
        uint j = 0; // arr2指针
        uint k = 0; // 结果数组指针
        
        // 创建结果数组，长度为两个输入数组长度之和
        uint[] memory result = new uint[](arr1.length + arr2.length);  //uint等价于 uint256 
        
        // 双指针遍历比较
        while (i < arr1.length && j < arr2.length) {
            if (arr1[i] <= arr2[j]) {
                result[k] = arr1[i];
                i++;
            } else {
                result[k] = arr2[j];
                j++;
            }
            k++;
        }
        
        // 处理剩余元素
        while (i < arr1.length) {
            result[k] = arr1[i];
            i++;
            k++;
        }
        
        while (j < arr2.length) {
            result[k] = arr2[j];
            j++;
            k++;
        }
        
        return result;
    }
}