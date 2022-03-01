// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.12;

contract P2PLoan {
    enum Status { Pending, Active, Repaid }

    struct Lender {
        string name;
        address identity;        
    }

    struct Borrower {
        string name;
        address identity;
    }

    Status status;
    Lender lender;
    Borrower borrower;
    uint16 interestRate; // Max is 10000 or 100%
}