// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.11;

import "./P2PLoanFactory.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @notice Protocol for collateralized peer-to-peer lending.
 */
contract P2PLender is P2PLoanFactory {

    event Lending(address indexed lender, uint loanAmount);
    event Approved(address indexed lender, address indexed borrower, uint loanAmount, uint16 interestRate);
    event Collateralized(address indexed borrower, uint collateral, string symbol);
    event Borrowed(address indexed borrower, uint loanAmount);
    
    /**
    * @notice Step 1: Lenders put funds in the contract.
    */ 
    function lend() external payable {
        _lend(msg.sender, msg.value); 
        emit Lending(msg.sender, msg.value);
    }

    /**
    * @notice Step 2: Lenders approve a borrower (note: funds are not released until collateral is submitted).
    *
    * @param loanAmount is expressed as an integer (for now only dollars and no cents)
    * @param interestRate is expressed as an integer (for now only whole rates, 0-100)
    */ 
    function approve(address borrower, uint loanAmount, uint16 interestRate) external {
        _approve(msg.sender, borrower, loanAmount, interestRate); 
        emit Approved(msg.sender, borrower, loanAmount, interestRate);
    }

    /**
    * @notice Step 3: Borrower submits collateral in the form of any whitelisted ERC20 token. 
    */
    function collateralize(address borrower, uint collateral, string memory name, string memory symbol) external payable {
        _collateralize(borrower, collateral, name, symbol);
        emit Collateralized(borrower, collateral, symbol);
    } 

    /**
    * @notice Step 4: Borrower withdraws funds.
    */ 
    function borrow() external {
        uint256 loanAmount = _getBalanceApproval(msg.sender);
        _borrow(payable(msg.sender), loanAmount);
        emit Borrowed(msg.sender, loanAmount);
    }

}
