// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";
import "./P2PLoan.sol";

/// @title A protocol for friends and family to borrow aginst collateral.
contract P2PLender is Ownable {

    P2PLoan[] private loans;

    /// @param _rate Min is 0, Max is 10000 (100%)
    function proposeLoan(
        address _from, 
        address _to, 
        uint _amount, 
        uint16 _rate
    ) 
        external 
    {

    }

    function acceptLoan(
        address _from, 
        address _to, 
        uint _amount, 
        uint16 _rate
    ) 
        external 
    {
        
    }

    function loanDetail(address _from) external view {

    }

    function getLoans() external view returns(P2PLoan[]){
        
    }
}
