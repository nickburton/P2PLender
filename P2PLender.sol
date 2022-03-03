// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.12;

import "./P2PLoanFactory.sol";

/**
 * @notice Worker contract to read & write Loans balance to the chain.
 */
contract P2PLender is P2PLoanFactory {

    event Lent(address indexed lender, uint loanAmount);
    event Approved(address indexed lender, address indexed borrower, uint loanAmount, uint16 interestRate);
    event Collateralized(address indexed lender, address indexed borrower, uint loanAmount);
    event Borrowed(address indexed borrower, uint loanAmount);
    
    /**
    * @notice tep 1: Lenders put funds into the contract.
    */ 
    function lend() external payable {
        _lend(msg.sender, msg.value); 
        emit Lent(msg.sender, msg.value);
    }

    /**
    * @notice Step 2: Lenders approve a borrower (funds not released until collateral submitted).
    * @param interestRate expressed as an integer, only whole numbers 0-100
    */ 
    function approve(address borrower, uint loanAmount, uint16 interestRate) external {
        _approve(msg.sender, borrower, loanAmount, interestRate); 
        emit Approved(msg.sender, borrower, loanAmount, interestRate);
    }

    /**
    * @notice Step 3: Borrower submits collateral in the form of any ERC20 token. 
    */
    function collateralize(address borrower) external payable {

    } 

    /**
    * @notice Step 4: Borrower withdraws funds.
    */ 
    function borrow() external {
        uint256 loanAmount = _getBalanceApproval(msg.sender); // check this out
        _borrow(payable(msg.sender), loanAmount);
        emit Borrowed(msg.sender, loanAmount);
    }

    
   
}
