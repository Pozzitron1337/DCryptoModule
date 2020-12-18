let Web3 = require('web3');
var path = require('path');

var path_to_contract='build/contracts/CryptoModule.json';
var network_id=5777;
var addres_to_blockchain='http://127.0.0.1:7545';

const { exit } = require('process');
var contractJSON = require(path.join(__dirname+'/../', path_to_contract));
var decoded = JSON.parse(JSON.stringify(contractJSON.networks,undefined, 2));
var contract_address = decoded[network_id].address;
var abi = contractJSON.abi;
const web3 = new Web3(new Web3.providers.WebsocketProvider(addres_to_blockchain));
let CryptoModuleContract = new web3.eth.Contract(abi, contract_address);


var sender='0x21a02541a1A2Fbe308Bed60A5dcc7A0D684D967e';
var receiver='0x9404deDDCb65f63850db43C281CDE47Da98C66ee';

CryptoModuleContract.methods
    .encrypted(receiver,"abracadabra")
    .send({from:sender,gas: 100000, gasPrice: "2000000000"})
// var message='test';
// var messageHash=web3.utils.keccak256(message);


// console.log('Message: '+message);
// console.log('Message hash: '+messageHash);
