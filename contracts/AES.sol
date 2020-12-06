// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;
pragma experimental ABIEncoderV2;


interface CryptoModule{
    
}

abstract contract SymCryptoModule is CryptoModule{
    function encrypt(address sender,bytes32 messageHash) virtual public;
    function decrypt(address sender,bytes32 senderTransactionHash) virtual public;
}

contract AES is SymCryptoModule{

    function encrypt(address sender,bytes32 messageHash) public override {

    }

    function decrypt(address sender,bytes32 senderTransactionHash) public override{
        
    }
}
