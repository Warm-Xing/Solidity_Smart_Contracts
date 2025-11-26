// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch {
    // 在有序数组中查找目标值，返回索引（未找到返回-1）
    function binarySearch(uint[] memory arr, uint target) public pure returns (int) {
        // 处理空数组情况
        if (arr.length == 0) return -1;
        
        int low = 0;
        int high = int(arr.length) - 1;
        
        while (low <= high) {
            // 计算中间索引（避免溢出）
            int mid = low + (high - low) / 2;
            uint midValue = arr[uint(mid)];
            
            if (midValue == target) {
                return mid; // 找到目标，返回索引
            } else if (midValue < target) {
                low = mid + 1; // 目标在右半部分
            } else {
                high = mid - 1; // 目标在左半部分
            }
        }
        
        return -1; // 未找到目标
    }
}