// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyERC20Token {
    string public name;
    string public symbol;
    uint8 public decimals = 18;
    //uint256 public totalSupply;
    uint256 public ethbalance;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    address public owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not the owner");
        _;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];  //其实相当于_balances[address]
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(recipient != address(0), "Transfer to the zero address");
        require(_balances[msg.sender] >= amount, "Insufficient balance");

        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "Approve to the zero address");
        
        _allowances[msg.sender][spender] = amount;//内外键，授权者（你） → 被授权者（如Uniswap交易所）记录授权关系
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        require(sender != address(0), "Transfer from the zero address");
        require(recipient != address(0), "Transfer to the zero address");
        require(_balances[sender] >= amount, "Insufficient balance");
        require(_allowances[sender][msg.sender] >= amount, "Allowance exceeded");

        _allowances[sender][msg.sender] -= amount;
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }

    function mint(address account, uint256 amount) public onlyOwner returns (bool) {//这里先调用onlyOwner修饰符，执行onlyOwner中_;之前的代码，然后再_;再跳入到主程序
        require(account != address(0), "Mint to the zero address");
        
        //totalSupply += amount;
        ethbalance += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);
        return true;
    }
}