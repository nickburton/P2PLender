// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.12;

import "./P2PLoanFactory.sol";

/** 
 * @title Protocol for friends and family to borrow aginst collateral
 */
contract P2PLender is P2PLoanFactory {

    /**
     * @notice For Borrower to initiate a Loan
     * @param interestRate Min is 0, Max is 10000 (100%)
     */
    function proposeLoan(uint16 interestRate, uint loanAmount, address from, address to) external {
        _createLoan(interestRate, loanAmount, from, to);
    }

    

    function loanDetail(address from) external view {

    }

   
}
