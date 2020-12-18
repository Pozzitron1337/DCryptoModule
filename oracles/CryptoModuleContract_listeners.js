
let Web3 = require('web3')
var path = require('path');

var path_to_contract='build/contracts/CryptoModule.json';
var network_id = 5777;
var addres_to_blockchain='http://127.0.0.1:7545';

var contractJSON = require(path.join(__dirname+'/../', path_to_contract))
var decoded = JSON.parse(JSON.stringify(contractJSON.networks,undefined, 2));
var contract_address = decoded[network_id].address;
var abi = contractJSON.abi;
const web3 = new Web3(new Web3.providers.WebsocketProvider(addres_to_blockchain));
var CryptoModuleContract = new web3.eth.Contract(abi, contract_address);


CryptoModuleContract.events.Encrypted(
    function(error,event){
        console.log('ENCRYPTED HANDLER');
        console.log(event);
    }
)
CryptoModuleContract.events.Operation(
    function(error,event){
        console.log('OPERATION HANDLER');
        console.log(event);
    }
)

