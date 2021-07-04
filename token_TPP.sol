pragma solidity ^0.8.4;

contract ERC20token{
    
    string public name = "TrungPhuc token";
    string public symbol = "TPP";
    uint public totalSupply = 1000000 * 10**18;
    uint public decimals = 18;
    
    
    address owner;
    
    mapping(address => uint) balances;
    mapping(address => mapping( address => uint)) allowance;
    
    event Transfer(address _from, address _to, uint _amount);
    event Approval(address _from, address _to, uint _amount);
    
    constructor() {
        owner = msg.sender;
        balances[msg.sender] = totalSupply;
    }
    
    function transfer(address _to, uint _amount) public payable returns(bool){
        uint gas = 1;
        require(balances[msg.sender] >= (_amount + gas),"Not enough money to send");
        require(msg.value == 1 ether, "Not enough money-fee to send");
        balances[msg.sender] -= (_amount + gas);
        balances[_to] += _amount;
        
        emit Transfer(msg.sender, _to, _amount);
        
        return true;
    }
    // => can be tách ra làm quy trình gián tiếp
    // alice cho bob mựn 10 t<3p -> 
    function approve(address _to, uint _amount) public returns(bool){
        require(balances[msg.sender] >= _amount, " Not enough money to allowance");
        allowance[msg.sender][_to] = _amount;
        emit Approval(msg.sender,_to, _amount);
        
        return true;
    }
    
    function transferFrom(address _from, address _to, uint _amount) public returns (bool){
        require(allowance[_from][msg.sender] >= _amount , " The accout from lender is not enough money to borrow");
        require(balances[_from] >= _amount, "The accout from lender is not enough money");
        balances[_from] -= _amount;
        balances[_to] += _amount;
        allowance[_from][msg.sender] -= _amount;
        
        emit Transfer(_from, _to, _amount);
        
        return true;
        
    }
    
    function TotalSupply() public view returns(uint){
        return totalSupply;
    }
    
    function balanceOf(address _address) public view returns(uint){
        return balances[_address];
    }
    
    
    
}