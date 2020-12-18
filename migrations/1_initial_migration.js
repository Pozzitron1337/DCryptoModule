const CryptoModuleContract = artifacts.require("CryptoModule");

module.exports = function (deployer) {
  deployer.deploy(CryptoModuleContract,228);
};
