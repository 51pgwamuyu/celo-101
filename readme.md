#CELO-101


What is Celo?
Celo is a blockchain platform designed with a focus on financial inclusion, particularly targeting emerging markets. It aims to make cryptocurrency accessible to mobile phone users without requiring sophisticated hardware like traditional Bitcoin miners do.For more details vist [celo](https://celo.org/)

We will go through an example of a celo smart contract written in solidity for  art marketplace
\`\`\`solidity
pragma solidity ^0.8.0;

contract MyContract {
    uint256 public myNumber;

    constructor(uint256 _myNumber) {
        myNumber = _myNumber;
    }

    function updateNumber(uint256 _newNumber) public {
        myNumber = _newNumber;
    }
}
\`\`\`
