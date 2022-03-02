// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/access/Ownable.sol";
// import "hardhat/console.sol";

contract P2PLoanFactory is Ownable {
        
    enum Status {Pending, Approved, Loaned, Abandoned, Repaid}

    struct P2PLoan {
        Status status;
        /// @notice interestRate has a max value of 10000 (100%), minimum is 0 (0%)
        uint16 interestRate; 
        uint256 loanAmount;
        address lender;
        address borrower;
    }

    P2PLoan[] private loans;
    mapping(address => uint) lenderToLoanId;  

    event NewP2PLoan(uint16 interestRate, uint loanAmount, address indexed lender, address indexed borrower);
    
    function _createLoan(uint16 interestRate, uint256 loanAmount, address lender, address borrower) internal {
        require(interestRate >= 0 && interestRate <= 10000, "Interest Rate must be between 0% and 100% (0 and 10000).");
        require(loanAmount >= 0, "The loaned amount must be more than 0.");
        loans.push(P2PLoan(Status.Pending, interestRate, loanAmount, lender, borrower));
        uint loanId = loans.length - 1;
        lenderToLoanId[lender] = loanId;
        emit NewP2PLoan(interestRate, loanAmount, lender, borrower);
    }

    function _approveLoanForLender(address lender) private {
        P2PLoan storage loan = loans[lenderToLoanId[lender]];
        loan.status = Status.Approved;
    }

    function _getLoanIdForLender(address lender) private view returns(uint) { 
        return lenderToLoanId[lender];
    }

}