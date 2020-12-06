let Web3 = require('web3');
var path = require('path');
var ethers=require('ethers')

var path_to_contract='build/contracts/RSA.json';
var network_id=5777;
var addres_to_blockchain='ws://127.0.0.1:7545';

const { exit } = require('process');
var contractJSON = require(path.join(__dirname+'/../', path_to_contract));
var decoded = JSON.parse(JSON.stringify(contractJSON.networks,undefined, 2));
var contract_address = decoded[network_id].address;
var abi = contractJSON.abi;
const web3 = new Web3(new Web3.providers.WebsocketProvider(addres_to_blockchain));
let RSAContract = new web3.eth.Contract(abi, contract_address);


var sender='0xae01549c7a291e63bB812785ccddC71D7Beb870A'
var receiver='0xEbB1BD2540f14cFfcBCAd1CE7E6f328D51E53723';

var message='test';
var messageHash=web3.utils.keccak256(message);
var txHash='0x505fb2ab515e36e497430367dac099a0b1739728448824181cf31ccf12436c63'; 

console.log('Message: '+message);
console.log('Message hash: '+messageHash);
console.log('Test transaction hash: '+txHash);

function generateKey(){
    RSAContract.methods
    .generateKey()
    .send({from: sender,gas: 100000, gasPrice: "2000000000"})
    .on('error', (error)=>{
        console.log(error);
        exit();
    })
    .once('transactionHash', (hash) => {
        console.log('GenKey transaction hash: ' + hash);
    })
}


function encrypt(){
    RSAContract.methods
    .encrypt(receiver,messageHash)
    .send({from: sender,gas: 100000, gasPrice: "2000000000"})
    .on('error', (error)=>{
        console.log(error);
        exit();
    })
    .once('transactionHash', (hash) => {
        console.log('Encrypt transaction hash: ' + hash);
    })
}

function decrypt(){
    RSAContract.methods
    .decrypt(sender,txHash)
    .send({from: receiver,gas: 100000, gasPrice: "2000000000"})
    .on('error', (error)=>{
        console.log(error);
        exit();
    })
    .once('transactionHash', (hash) => {
        console.log('Decrypt transaction hash: ' + hash);

    })
}
generateKey();
encrypt();
decrypt();
