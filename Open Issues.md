Issues to Address

0. Functions as constant?
1. we need a whitelist for accepted tokens and a collateral weighting for each 
0. Remove approvals after 
1. A need for overcollateralization in case the locked up token goes down in value. 
2. Re-entrance issue
3. Upgradable contract https://medium.com/@maltabba/essential-design-consideration-for-ethereum-dapps-1-upgradeable-smart-contracts-b4fb21e1fd89
4. Allow authorized return of funds (in case of emergencies)
5. Consider issuing an ERC20 token as receipt of funds lent to the contract? 
6. decimals in the loan amount or interest rate 


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




