// SPDX-License-Identifier: MIT
// Receives ETH and send back *100 PTKN
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.3.2/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.3.2/contracts/access/Ownable.sol";

contract PayableToken is Ownable, ERC20 {
    // 100 milions subtokens (10^18 subtokens in 1 token)
    uint private constant _maxSupply = 100 * (10 ** 6) * (10 ** 18);
                                        
    constructor() ERC20("PayableToken", "PTKN") {}
    
    function destroy() public onlyOwner{
        selfdestruct(payable(owner()));
    }
    
    receive() external payable {
        require(msg.value > 0, "Need ETH to buy PTKN!");
        
        uint avaliableSupply = _maxSupply - totalSupply();
        require(avaliableSupply >= 100, "No more PTKN available!");
        
        uint requestSupply = msg.value * 100;
        if(requestSupply > avaliableSupply){
            uint price = (avaliableSupply / 100);
            payable(owner()).transfer(price);
            _mint(msg.sender, price * 100);
            payable(msg.sender).transfer(msg.value - price);
        }
        else{
            payable(owner()).transfer(msg.value);
            _mint(msg.sender, msg.value * 100);
        }
    }
}