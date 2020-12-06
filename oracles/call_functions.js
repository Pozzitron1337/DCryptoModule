let Web3 = require('web3')
var path = require('path');
const { keccak256 } = require("ethereum-cryptography/keccak");

var path_to_contract='build/contracts/RSA.json';
var network_id=5777;
var addres_to_blockchain='ws://127.0.0.1:7545';

const { exit } = require('process');
const { reverse } = require('dns');
const { type } = require('os');
var contractJSON = require(path.join(__dirname+'/../', path_to_contract));
var decoded = JSON.parse(JSON.stringify(contractJSON.networks,undefined, 2));
var contract_address = decoded[network_id].address;
var abi = contractJSON.abi;
const web3 = new Web3(new Web3.providers.WebsocketProvider(addres_to_blockchain));
let RSAContract = new web3.eth.Contract(abi, contract_address);

var message='test';
var sender='0x4c9c67a70e4DC38A1E9BA3282aF8e9c6B439E162'
var receiver='0x45110A3808404A58FcF0E317620ad201A4d907e6';

var messageHash=keccak256(Buffer.from(message, "utf8")).toString("hex")
console.log('Message: '+message);
console.log('Message hash: '+messageHash);


function encrypt(){
    RSAContract.methods
    .encrypt(receiver,messageHash)
    .send({from: sender,gas: 100000, gasPrice: "2000000000"})
    .on('error', (error)=>{
        console.log(error);
        exit();
    })
    .once('transactionHash', (hash) => {
        txHash=hash;
        console.log('transaction hash: ' + hash);
        exit();
    })
}
var txHash="";
function decrypt(){
    RSAContract.methods
    .decrypt(sender,txHash)
    .send({from: receiver,gas: 100000, gasPrice: "2000000000"})
    .on('error', (error)=>{
        console.log(error);
        exit();
    })
    .once('transactionHash', (hash) => {
        console.log('transaction hash: ' + hash);
        exit();
    })
}
encrypt();
decrypt();