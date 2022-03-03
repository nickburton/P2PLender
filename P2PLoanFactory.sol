// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Base contract that reads & writes to the chain.
 */
contract P2PLoanFactory is Ownable {
        
    struct P2PLoan {
        address lender;
        uint256 loanAmount;
        uint16 interestRate; 
    }

    mapping(address => uint) received;
    mapping(address => P2PLoan) approved; ///@notice Maps approved Borrowers to their Lender and Loan 

    function _lend(address lender, uint loanAmount) internal {
        require(loanAmount > 0, "You need to send some ether");
        received[lender] = loanAmount;
    }

    function _approve(address lender, address borrower, uint loanAmount, uint16 interestRate) internal {
        require(loanAmount > 0, "The loan approval must be for more than 0.");
        require(interestRate >= 0 && interestRate <= 100, "Interest Rate must be 0-100 (0%-100%).");
        approved[borrower] = P2PLoan(lender, loanAmount, interestRate);
    }

    function _collateralize() internal {
        
    }

    function _borrow(address payable borrower, uint loanAmount) internal {
        require(loanAmount <= contractBalance(), "Not enough funds in the contract."); 
        
        P2PLoan memory loan = approved[borrower];
        address lender = loan.lender;
        received[lender] -= loanAmount;
        delete approved[borrower]; // TODO need another solution for this?
        borrower.transfer(loanAmount);
    }

    function _getBalanceApproval(address borrower) internal returns(uint) {
        return approved[borrower].loanAmount; 
    }

    function contractBalance() private returns(uint) {
        return address(this).balance; //TODO, does "this" here mean LoanFactory or P2PLender? Needs to be P2PLender
    } 

}

