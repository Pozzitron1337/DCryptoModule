// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;
pragma experimental ABIEncoderV2;

//import "./CryptoModule.sol";

abstract contract AsymCryptoModule{
    function generateKey() virtual public;
    function encrypt(address sender,bytes32 messageHash) virtual public;
    function decrypt(address sender,bytes32 transactionHash) virtual public;
    function sign() virtual public;
    function verify() virtual public;
    
}

contract RSA is AsymCryptoModule{

    string public constant ALGORITHM_NAME="RSA";
    struct RSA_PublicKey{
        string n;
        string e;
    }
    mapping(address => RSA_PublicKey) publicKeys;// store public keys
   
    event generateKey_oracle(address);
    event encrypt_oracle(address sender,address receiver,RSA_PublicKey publicKey,bytes32 messageHash);
    event decrypt_oracle(address receiver,address sender,bytes32 transactionHash);
    event sign_oracle();
    event verify_oracle();

    function generateKey() public override{
        emit generateKey_oracle(msg.sender);
    }

    function setPublicKey(string memory _n,string memory _e) public {
        publicKeys[msg.sender].n=_n;
        publicKeys[msg.sender].e=_e;
    }

    function getPublicKey(address _address) public view returns(string memory,string memory){
        require(bytes(publicKeys[_address].n).length>0);//TODO think about checking
        return (publicKeys[_address].n,publicKeys[_address].e);
    }

    function encrypt(address _to,bytes32 messageHash) public override {
        emit encrypt_oracle(msg.sender,_to,publicKeys[_to],messageHash);
    }

    function decrypt(address sender,bytes32 transactionHash) public override {
        emit decrypt_oracle(msg.sender,sender,transactionHash);
    }

    function sign()  public override{
        emit sign_oracle();
    }
    
    function verify() public override{
        emit verify_oracle();
    }
 
}
