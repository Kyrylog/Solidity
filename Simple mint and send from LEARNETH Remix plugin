pragma solidity >=0.5.0 <0.7.0;

contract Coin {
    address public minter;
    mapping (address => uint) public balances;
    uint256 public amount;
    event Sent(address from, address to, uint amount);

    constructor() public {
        minter = msg.sender;
        
    }   
    
    function mint(address receiver, uint _amount) public {
        require(receiver==minter && _amount<1*(10^6));
        balances[receiver]+=_amount;
    }    
    
    function send(address receiver, uint _amount) public {
        require(balances[minter]>_amount, "bad boy");
        balances[minter]-=_amount;
        balances[receiver]+=_amount;
        amount=_amount;
        emit Sent(minter, receiver, amount);
    }
    
