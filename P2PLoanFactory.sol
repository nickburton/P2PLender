// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/access/Ownable.sol";
// import "hardhat/console.sol";

/**
 * @title Contract for lending against collateral.
 * @dev Contract with business logic ...
 */
contract P2PLoanFactory is Ownable {
        
    // enum Status {Pending, Approved, Loaned, Abandoned, Repaid}

    struct P2PLoan {
        
        /// @notice interestRate has a max value of 10000 (100%), minimum is 0 (0%)
        uint16 interestRate; 
        uint256 loanAmount;
        address lender;
        address borrower;
        // Status status; // TODO: Unused
    }

    // P2PLoan[] private loans;
    // mapping(address => uint) lenderToLoanId;  
    // event NewP2PLoan(uint16 interestRate, uint loanAmount, address indexed lender, address indexed borrower);

    mapping(address => uint) received;
    mapping(address => mapping(address => P2PLoan)) approved;

    function _lend(address lender, uint loanAmount) internal {
        require(loanAmount > 0, "You need to send some ether");
        received[lender] = loanAmount;
    }

    function _approve(address lender, address borrower, uint loanAmount, uint16 interestRate) internal {
        require(loanAmount > 0, "The loan approval must be for more than 0.");
        require(interestRate >= 0 && interestRate <= 100, "Interest Rate must be 0-100 (0%-100%).");
        approved[lender][borrower] = P2PLoan(interestRate, loanAmount, lender, borrower);
    }

    function _getBalanceAmount(address borrower) internal returns(uint) {
        return 0; 
        /**
        * TODO How do I get the borrower here to look up the loan??
        *
        */
    }

    function _borrow(address payable borrower, uint loanAmount) internal {
        require(loanAmount <= contractBalance(), "Not enough funds in the contract."); 
        borrower.transfer(loanAmount); 
    }

    function contractBalance() private returns(uint) {
        return address(this).balance; //To Do, does this here mean LoanFactory or P2PLender?
    } 

    // function _createLoan(uint16 interestRate, uint256 loanAmount, address lender, address borrower) internal {
        
    //     loans.push(P2PLoan(Status.Pending, interestRate, loanAmount, lender, borrower));
    //     uint loanId = loans.length - 1;
    //     lenderToLoanId[lender] = loanId;
    //     emit NewP2PLoan(interestRate, loanAmount, lender, borrower);
    // }

    // function _approveLoanForLender(address lender) private {
    //     P2PLoan storage loan = loans[lenderToLoanId[lender]];
    //     loan.status = Status.Approved;
    // }

    // function _getLoanIdForLender(address lender) private view returns(uint) { 
    //     return lenderToLoanId[lender];
    // }

}

