// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.12;

import "./P2PLoanFactory.sol";

/**
 * @notice Worker contract to read & write Loans balance to the chain.
 */
contract P2PLender is P2PLoanFactory {

    /**
     * @notice For Borrower to initiate a Loan
     * @param interestRate Min is 0, Max is 10000 (100%)
     */
    function proposeLoan(uint16 interestRate, uint loanAmount, address lender, address borrower) external {
        _createLoan(interestRate, loanAmount, lender, borrower);
    }

    

    function loanDetail(address from) external view {

    }

//     mapping(address => uint256) balances;
// mapping(address => mapping (address => uint256)) approved;
// 		^^^ msg.sender 		^^^ borrower	^^^

// mapping(address => mapping (address => P2PLoan)) approved;


//     function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool) {
//         require(numTokens <= balances[owner]);
//         require(numTokens <= allowed[owner][msg.sender]);

//         balances[owner] = balances[owner].sub(numTokens);
//         allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
//         balances[buyer] = balances[buyer].add(numTokens);
//         emit Transfer(owner, buyer, numTokens);
//         return true;
//     }

// function balanceOf(address tokenOwner) public override view returns (uint256) {
//         return balances[tokenOwner];
//     }

    /**
    * Step 1: Lenders put funds into the contract.
    */ 
    function lend() external payable {
        uint256 loanAmount = msg.value;
        require(loanAmount > 0, "You need to send some ether");
        _recieveFrom(msg.sender, loanAmount); 
    }

    /**
    * Step 2: Lenders approve a borrower (funds not released until collateral submitted).
    */ 
    function approve(address borrower, ufixed loanAmount, uint16 interestRate) external {
        require(loanAmount > 0, "You need to approve a non-zero loan balance.");
        // require(loanAmount >= 0 && interestRate <= , "You need to approve a non-zero loan balance.");
        _approve(msg.sender, borrower, loanAmount, interestRate); 
    }

    /**
    * Step 3: Borrower submits collateral. 
    */ 

        


//     Step 4: Borrow Funds

//     function borrow() {
//         uint256 loanAmount = balances.withdrawable(msg.sender, address(this)); // check this out
//         uint256 contractBalance = balanceOf(address(this));
//         require(loanAmount <= contractBalance, "Not enough funds in the contract");
        
//         function transfer(address recipient, uint256 amount) external returns (bool);

//         msg.sender.transfer(amount); // transfer to the borrower
//         emite Borrowed(Address or LoanId, amount);
//     }
   
}
