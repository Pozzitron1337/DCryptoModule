// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;
pragma experimental ABIEncoderV2;

interface CryptoModule{
    
}

abstract contract AsymCryptoModule{
    function generateKey() virtual public;
    function encrypt(address sender,bytes32 messageHash) virtual public;
    function decrypt(address sender,bytes32 senderTransactionHash) virtual public;
    function sign(address receiverAddress,string memory message) virtual public;
    function verify(address signerAddress,bytes32 signTransactionHash) virtual public;
}

contract RSA is AsymCryptoModule{
    string public constant ALGORITHM_NAME="RSA";
    string public constant HASH_FUNCTION="keccak256";
    struct RSA_PublicKey{
        string n;
        string e;
    }
    mapping(address => RSA_PublicKey) publicKeys;// store public keys
   
    event generateKey_oracle(address sendersAddress);
    event encrypt_oracle(address sender,address receiverAddress,RSA_PublicKey publicKey,bytes32 messageHash);
    event decrypt_oracle(address receiverAddress,address sender,bytes32 senderTransactionHash);
    event sign_oracle(address sender,address receiverAddress,string message);
    event verify_oracle(address sender,address receiverAddress,bytes32 senderTransactionHash);

    function generateKey() public override{
        emit generateKey_oracle(msg.sender);
    }

    function setPublicKey(string memory _n,string memory _e) public {
        require(bytes(_n).length>0 && bytes(_e).length>0);
        publicKeys[msg.sender].n=_n;
        publicKeys[msg.sender].e=_e;
    }

    function getPublicKey(address _address) public view returns(string memory,string memory){
        require(bytes(publicKeys[_address].n).length>0);//TODO think about checking
        return (publicKeys[_address].n,publicKeys[_address].e);
    }

    function encrypt(address receiverAddress,bytes32 messageHash) public override {
        emit encrypt_oracle(msg.sender,receiverAddress,publicKeys[receiverAddress],messageHash);
    }

    function decrypt(address senderAddress,bytes32 senderTransactionHash) public override {
        emit decrypt_oracle(msg.sender,senderAddress,senderTransactionHash);
    }

    function sign(address receiverAddress,string memory message) public override{
        emit sign_oracle(msg.sender,receiverAddress,message);
    }
    
    function verify(address signerAddress,bytes32 signTransactionHash) public override{
        emit verify_oracle(msg.sender,signerAddress,signTransactionHash);
    }
 
}
