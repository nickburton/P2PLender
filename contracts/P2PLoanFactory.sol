// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.11;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
// import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title Base contract that reads & writes to the chain.
 */
contract P2PLoanFactory is Ownable {
        
    enum Status {Approved, Borrowed}

    struct P2PLoan {
        address lender;
        uint loanAmount;
        uint16 interestRate; 
        Status status;
    }

    ///@notice Lenders to loaned amounts
    mapping(address => uint) loaned;
    
    ///@notice Borrowers to collateral deposits
    mapping(address => uint) collateral;   

    ///@notice Borrowers to loan details
    mapping(address => P2PLoan) approved;       

    function _lend(address lender, uint loanAmount) internal {
        require(loanAmount > 0, "You need to send some ether.");
        require(lender != address(0), "Lender can't be the zero address.");
        loaned[lender] = loanAmount;
    }

    function _approve(address lender, address borrower, uint loanAmount, uint16 interestRate) internal {
        require(loanAmount > 0, "The loan approval must be for more than 0.");
        require(interestRate >= 0 && interestRate <= 100, "Interest Rate must be 0-100 (0%-100%).");
        require(lender != address(0), "Lender can't be the zero address.");
        require(borrower != address(0), "Borrower can't be the zero address.");
        approved[borrower] = P2PLoan(lender, loanAmount, interestRate, Status.Approved);
    }

    function _collateralize(address borrower, uint collateral, string memory tokenName, string memory tokenSymbol) internal {
        ERC20 token = new ERC20(tokenName, tokenSymbol);
        
    }

    function _borrow(address payable borrower, uint loanAmount) internal {
        require(loanAmount <= contractBalance(), "Not enough funds in the contract."); 
        require(borrower != address(0), "Borrower can't be the zero address.");
        P2PLoan storage loan = approved[borrower];
        loan.status = Status.Borrowed;
        borrower.transfer(loanAmount);
    }

    function _getBalanceApproval(address borrower) internal returns(uint) {
        return approved[borrower].loanAmount; 
    }

    function contractBalance() private returns(uint) {
        return address(this).balance; //TODO, does "this" here mean LoanFactory or P2PLender? Needs to be P2PLender
    } 

}

