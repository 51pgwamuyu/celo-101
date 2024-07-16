#CELO-101


What is Celo?
Celo is a blockchain platform designed with a focus on financial inclusion, particularly targeting emerging markets. It aims to make cryptocurrency accessible to mobile phone users without requiring sophisticated hardware like traditional Bitcoin miners do.For more details vist [celo](https://celo.org/)

We will go through an example of a celo smart contract written in solidity for  art marketplace


// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

SPDX-License-Identifier: This is a standard way to identify the license of a software project, It helps in automatically identifying the license of a piece of software, which is crucial for compliance and legal reasons.

pragma solidity >=0.7.0 <0.9.0;

pragma solidity: This line specifies the compiler version for the Solidity code.>=0.7.0 <0.9.0: This range indicates that the smart contract is compatible with Solidity compiler versions 0.7.0 and higher, but less than version 0.9.0. Specifying a range of compiler versions is important because different versions may introduce changes or deprecations in the language syntax or features. By limiting the range, the coder ensures that the contract behaves consistently across a set of compiler versions, avoiding unexpected behavior due to compiler differences.



interface IERC20Token {
    function transfer(address, uint256) external returns (bool);

    function approve(address, uint256) external returns (bool);

    function transferFrom(
        address,
        address,
        uint256
    ) external returns (bool);

    function totalSupply() external view returns (uint256);

    function balanceOf(address) external view returns (uint256);

    function allowance(address, address) external view returns (uint256);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

The IERC20Token interface outlines the standard functions and events defined by the ERC-20 token standard.To understand this we will go through each function defined above.

**Why ERC-20?8**
The ERC-20 standard defines a common list of rules for all Ethereum tokens example celo, to follow, ensuring compatibility and predictability among different tokens. By adhering to this standard, token creators enable their tokens to be compatible with a wide range of wallets, exchanges, and decentralized applications (dApps) without needing to build custom interfaces for each integration point.

**Functions**

<span style="color:red">*function transfer(address to, uint256 value)*:</span> This function allows the caller (the sender) to transfer a specified amount of tokens to another address. It's a fundamental operation that enables any holder of tokens to send them to another account. The function returns a boolean indicating success (true) or failure (false).

<span styele="color:red">*function approve(address spender, uint256 value)*</span>: Before a token holder can spend tokens owned by someone else (for example, to pay a fee or make a payment on behalf of the original owner), they must obtain approval from the token owner. This function sets an allowance, specifying how many tokens the spender is allowed to move on behalf of the owner. It also returns a boolean indicating success or failure.

<span styele="color:red">*function transferFrom(address from, address to, uint256 value)*</span>: This function transfers a specified amount of tokens from one address to another. Unlike transfer, which moves tokens from the caller's address, transferFrom allows anyone who has been approved by the token owner to move tokens on their behalf. This is particularly useful for decentralized exchanges and other DeFi applications that need to move tokens between accounts without holding any tokens themselves.

<span styele="color:red">*function totalSupply()*</span>: Returns the total supply of tokens in existence. This is a constant value that represents the maximum number of tokens that will ever exist

<span styele="color:red">*function balanceOf(address account)*</span>: Queries and returns the current balance of tokens held by the specified address. This function is essential for checking the available funds before initiating transactions.

<span styele="color:red">*function allowance(address owner, address spender)*</span>: Returns the remaining number of tokens that the spender is still allowed to draw from the owner's account. This is part of the approval mechanism, allowing holders to see how much of their tokens have been approved for spending by others.


**Events**

<span styele="color:green">*Transfer(address indexed from, address indexed to, uint256 value)*</span>: This event is emitted whenever tokens are transferred from one address to another. The from and to addresses are indexed, meaning they can be queried easily, and the value indicates the amount of tokens transferred. This event is crucial for tracking token movements and auditing transactions.

<span styele="color:green">*Approval(address indexed owner, address indexed spender, uint256 value)*</span>: Emitted when the approve function is called, signaling that the spender is now allowed to withdraw up to a certain amount of tokens from the owner's account. Like the Transfer event, the owner and spender addresses are indexed, facilitating easy queries.



contract MyContract {
    uint256 public myNumber;

    constructor(uint256 _myNumber) {
        myNumber = _myNumber;
    }

    function updateNumber(uint256 _newNumber) public {
        myNumber = _newNumber;
    }
}

