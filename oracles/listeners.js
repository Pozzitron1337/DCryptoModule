
let Web3 = require('web3')
var path = require('path');

var path_to_contract='build/contracts/RSA.json';
var network_id = 5777;
var addres_to_blockchain='ws://127.0.0.1:7545';


var contractJSON = require(path.join(__dirname+'/../', path_to_contract))
var decoded = JSON.parse(JSON.stringify(contractJSON.networks,undefined, 2));
var contract_address = decoded[network_id].address;
var abi = contractJSON.abi;
const web3 = new Web3(new Web3.providers.WebsocketProvider(addres_to_blockchain));
var RSAContract = new web3.eth.Contract(abi, contract_address);


RSAContract.events.generateKey_oracle(
    function(error,event){
        console.log('************GENKEY*****************');
        console.log(event);
    }
)
RSAContract.events.encrypt_oracle(
    function(error,event){
        console.log('************ENCRYPT*****************');
        console.log(event);
    }
)
RSAContract.events.decrypt_oracle(
    function(error,event){
        console.log('************DECRYPT*****************');
        console.log(event);
    }
)

