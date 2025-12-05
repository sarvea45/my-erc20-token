// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MyToken
 * @dev Implementation of the ERC-20 Token Standard
 * Created for: Blockchain Development Submission
 */
contract MyToken {
    // --- Token Metadata ---
    string public name = "SarveshToken";
    string public symbol = "MTK";
    uint8 public decimals = 18; // Standard for Ethereum tokens (18 decimal places)
    uint256 public totalSupply;

    // --- State Variables ---
    // Mapping to track balances: Owner Address => Token Balance
    mapping(address => uint256) public balanceOf;
    
    // Mapping to track allowances: Owner Address => (Spender Address => Amount)
    mapping(address => mapping(address => uint256)) public allowance;

    // --- Events ---
    // Emitted when tokens are transferred (required by ERC-20 standard)
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    // Emitted when an owner approves a spender (required by ERC-20 standard)
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // --- Constructor ---
    // Initializes the contract and mints the initial supply to the deployer
    constructor(uint256 _initialSupply) {
        // Set the total supply
        totalSupply = _initialSupply;
        
        // Assign the entire supply to the contract creator (msg.sender)
        balanceOf[msg.sender] = totalSupply;
        
        // Emit Transfer event from zero address to signify minting
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    // --- Core Functions ---

    /**
     * @dev Moves `_value` tokens from the caller's account to `_to`.
     * Returns a boolean value indicating whether the operation succeeded.
     */
    function transfer(address _to, uint256 _value) public returns (bool success) {
        // Validation: Prevent transfer to the zero address (burning)
        require(_to != address(0), "Cannot transfer to zero address");
        // Validation: Check if sender has enough tokens
        require(balanceOf[msg.sender] >= _value, "Insufficient balance");

        // Update balances
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        // Emit the Transfer event
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    /**
     * @dev Sets `_value` as the allowance of `_spender` over the caller's tokens.
     * Returns a boolean value indicating whether the operation succeeded.
     */
    function approve(address _spender, uint256 _value) public returns (bool success) {
        require(_spender != address(0), "Cannot approve zero address");

        // Update allowance mapping
        allowance[msg.sender][_spender] = _value;

        // Emit the Approval event
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    /**
     * @dev Moves `_value` tokens from `_from` to `_to` using the allowance mechanism.
     * `_value` is then deducted from the caller's allowance.
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_to != address(0), "Cannot transfer to zero address");
        require(balanceOf[_from] >= _value, "Insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "Insufficient allowance");

        // Update balances
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        
        // Decrease the allowance
        allowance[_from][msg.sender] -= _value;

        // Emit the Transfer event
        emit Transfer(_from, _to, _value);
        return true;
    }
}