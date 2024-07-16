#CELO-101


What is Celo?
Celo is a blockchain platform designed with a focus on financial inclusion, particularly targeting emerging markets. It aims to make cryptocurrency accessible to mobile phone users without requiring sophisticated hardware like traditional Bitcoin miners do.For more details vist [celo](https://celo.org/)

We will go through an example of a celo smart contract written in solidity for  art marketplace


// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

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


SPDX-License-Identifier: This is a standard way to identify the license of a software project, introduced by the Software Package Data Exchange (SPDX) organization. It helps in automatically identifying the license of a piece of software, which is crucial for compliance and legal reasons.

pragma solidity >=0.7.0 <0.9.0;

pragma solidity: This line specifies the compiler version for the Solidity code. Solidity is the programming language used for writing smart contracts on the Ethereum blockchain.
>=0.7.0 <0.9.0: This range indicates that the smart contract is compatible with Solidity compiler versions 0.7.0 and higher, but less than version 0.9.0. Specifying a range of compiler versions is important because different versions may introduce changes or deprecations in the language syntax or features. By limiting the range, the author ensures that the contract behaves consistently across a set of compiler versions, avoiding unexpected behavior due to compiler differences.

contract MyContract {
    uint256 public myNumber;

    constructor(uint256 _myNumber) {
        myNumber = _myNumber;
    }

    function updateNumber(uint256 _newNumber) public {
        myNumber = _newNumber;
    }
}

