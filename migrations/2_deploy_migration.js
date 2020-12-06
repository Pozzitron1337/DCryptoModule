const RSAContract = artifacts.require("RSA");
const AESContract = artifacts.require("AES");
module.exports = function (deployer) {
  deployer.deploy(RSAContract);
  deployer.deploy(AESContract)
};