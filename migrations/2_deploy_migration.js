const CryptoModulesContract = artifacts.require("CryptoModule");
const RSAContract = artifacts.require("RSA");
module.exports = function (deployer) {
  //deployer.deploy(CryptoModulesContract);
  deployer.deploy(RSAContract);
};