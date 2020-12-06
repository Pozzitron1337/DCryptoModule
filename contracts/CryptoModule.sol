// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

interface CryptoModule{
    
}

abstract contract AsymCryptoModule is CryptoModule{
  
    function generateKey() virtual public;

    function encrypt(address,string memory) virtual public;

    function decrypt() virtual public;

    function sign() virtual public;

    function verify() virtual public;
    
}

abstract contract SymCryptoModule is CryptoModule{
    function cipher() virtual public;
}