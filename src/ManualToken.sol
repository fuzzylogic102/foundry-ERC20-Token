// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract ManualToken{

    //my_address/or anyaddress is assigned a balance   my_address -> 10 tokens.
    //Holdingh tokens in an erc-20 just means you have some sort of balance in a contract
    mapping(address=>uint256) private s_balances;

    // function name() public view returns (string memory){
    //     return "Manual Token";
    // }
    
    string public name = "Manual Token";

    function totaleSupply() public pure returns (uint256){
        return 100 ether; //this has 18 zeros so we makea decimal function to tell people the amoount of zeros
    }

    function decimals() public pure returns(uint256){
        return 18;
    }

    function balanceOf(address _owner) public view returns (uint256 balance){
        return s_balances[_owner];
    } 

    function transfer(address _to, uint256 _amount) public {
        uint256 previousBalance = balanceOf(msg.sender) + balanceOf(_to);
        s_balances[msg.sender] -= _amount;
        s_balances[_to] += _amount;
        require(balanceOf(msg.sender) + balanceOf(_to) == previousBalance);
    }
}