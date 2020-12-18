// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

import "./Ownable.sol";

contract CryptoModule is Ownable{
    
    struct PublicKey{
        string ALGORITHM_NAME;
        string KEY;
    }
    
    function generateRandomNumber(uint256 seed) public returns(uint256){
        generatorState=(generatorState+seed)^uint256(keccak256(abi.encodePacked(seed)));
        return uint256(keccak256(abi.encodePacked(block.timestamp^generatorState)));
    }
    
    mapping(address => PublicKey) public publicKeys;// storing public keys
    
    uint256 private generatorState;
    
    constructor(uint256 initialGeneratorState){
        generatorState=initialGeneratorState;
    }
    
    event Encrypted(address indexed sender,
                    address indexed receiver,
                    string cipherText);
    event Operation(address indexed sender,
                    address indexed receiver,
                    string operationName,
                    string operationCode,
                    string parametrs);
    
    modifier checkPublicKey(string memory algorithm_name,
                            string memory key){
        require(bytes(algorithm_name).length>0,"Algorithm name is empty!");
        require(bytes(key).length>0,"Public key is empty!");
        _;
    }
    
    //@dev 
    //@param key is json that stores open keys parametrs.
    //       for example RSA public key: key="{e:0x1000001,n:0x123456789ABCDE}"
    function setPublicKey(  string memory algorithm_name,
                            string memory key) 
    public checkPublicKey(algorithm_name,key) {
        publicKeys[msg.sender].ALGORITHM_NAME=algorithm_name;
        publicKeys[msg.sender].KEY=key;
    }
    
    function getPublicKey(address receiver) 
    public view returns(string memory algorithm_name,
                        string memory key){
        return (publicKeys[receiver].ALGORITHM_NAME,
                publicKeys[receiver].KEY);
    }
    
    function encrypted( address receiverAddress,
                        string memory cipherText)
    public {
        emit Encrypted(msg.sender,receiverAddress,cipherText);
    }
    
    //@dev operation is remote procedure,that handles by receiver.
    //@param operationName  is the name of operation.
    //@param operationCode is the raw code,that should be executed by receiver
    //@param parametrs is input to program
    function operation( address receiver,
                        string memory operationName,
                        string memory operationCode,
                        string memory parametrs)
    public {
        require(bytes(operationName).length>0,"Operation name should not be empty!");
        emit Operation(msg.sender,receiver,operationName,operationCode,parametrs);
    }
    
}
