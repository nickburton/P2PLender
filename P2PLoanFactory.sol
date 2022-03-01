// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract P2PLoanFactory is Ownable {
        
    enum Status {Pending, Loaned, Abandoned, Repaid}

    struct Lender {
        address wallet;        
    }

    struct Borrower {
        address wallet;
    }

    struct P2PLoan {
        /// @notice interestRate has a max value of 10000 (100%), minimum is 0 (0%)
        uint16 interestRate; 
        uint loanAmount;
        Status status;
        Lender lender;
        Borrower borrower;
    }

    P2PLoan[] private loans;

    event NewP2PLoan(uint16 interestRate, uint loanAmount, address indexed from, address indexed to);
    
    function _createLoan(uint16 interestRate, uint loanAmount, address from, address to) internal {
        require(interestRate <= 10000 && interestRate >= 0);
        loans.push(P2PLoan(interestRate, loanAmount, Status.Pending, Lender(from), Borrower(to)));
        uint id = loans.length;
        emit NewP2PLoan(interestRate, loanAmount, from, to);
    }
}