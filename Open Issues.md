Issues to Address

1. A need for overcollateralization in case the locked up token goes down in value. 
2. Re-entrance issue
3. Upgradable contract https://medium.com/@maltabba/essential-design-consideration-for-ethereum-dapps-1-upgradeable-smart-contracts-b4fb21e1fd89


4. Get solidity in Sublime https://techgeek628.medium.com/ethereum-solidity-language-syntax-in-sublime-7305e11e0fa9


The function responsible for the sell will first require the user to have approved the amount by calling the approve function beforehand. 

function sell(uint256 amount) public {
    require(amount > 0, "You need to sell at least some tokens");
    uint256 allowance = token.allowance(msg.sender, address(this));
    require(allowance >= amount, "Check the token allowance");
    token.transferFrom(msg.sender, address(this), amount);
    
    msg.sender.transfer(amount);
    

    emit Sold(amount);
}


mapping(address => uint256) balances;
mapping(address => mapping (address => uint256)) approved;
		^^^ msg.sender 		^^^ delegate	^^^

mapping(address => mapping (address => P2PLoan)) approved;


Step 1: Approve

function approve(address delegate, uint256 numTokens) public override returns (bool) {
        allowed[msg.sender][delegate] = numTokens;
        emit Approval(msg.sender, delegate, numTokens);
        return true;
    }

Step 2: Sell

receiveLoan() payable public {
	uint256 loanAmount = msg.value;
}

Step 3: Send Funds

function borrowFunds() {
	uint256 withdrawable = balances.withdrawable(msg.sender, address(this)); // check this out
	balances.transferFrom(msg.sender, address(this), amount); // update our contract balance
    msg.sender.transfer(amount); // transfer to the borrower
    emite Borrowed(Address or LoanId, amount);
}


