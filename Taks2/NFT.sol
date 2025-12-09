//项目图片https://app.pinata.cloud/ipfs/files https://app.pinata.cloud/ipfs/files#
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";  // ERC721核心标准
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";  // 元数据存储扩展
import "@openzeppelin/contracts/access/Ownable.sol"; // 所有权管理

contract MyNFT is ERC721, ERC721URIStorage, Ownable {
    uint256 public tokenIdCounter;  // NFT计数器（自动递增）

    constructor() ERC721("MyNFT", "MNFT") Ownable(msg.sender) {
        tokenIdCounter = 0;
    }
    // ERC721初始化：设置NFT名称（"MyNFT"）和符号（"MNFT")
    // Ownable初始化：将合约部署者设为所有者（msg.sender)
    // 计数器初始化：确保从0开始编号


    function mintNFT(address recipient, string memory tokenURI_) external onlyOwner returns (uint256) {
        require(recipient != address(0), "Mint to the 0 address"); // 安全校验
        uint256 newTokenId = tokenIdCounter; // 获取当前ID
        
        _safeMint(recipient, newTokenId);  // 安全铸造NFT（包含接收者校验）
        _setTokenURI(newTokenId, tokenURI_); // 关联IPFS元数据链接
        
        tokenIdCounter++;  // 计数器自增
        return newTokenId; // 返回铸造的NFT ID
    }

    // 解决ERC721与ERC721URIStorage的函数重写冲突
    function tokenURI(uint256 tokenId) 
        public view override(ERC721, ERC721URIStorage) 
        returns (string memory) 
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) 
        public view override(ERC721, ERC721URIStorage) 
        returns (bool) 
    {
        return super.supportsInterface(interfaceId);
    }
}
// 例如："ipfs://bafkreiexzs43llkdf6zx3kbqruzncsp5moe2eq42uesxhrtkeaf4j4yml4"
