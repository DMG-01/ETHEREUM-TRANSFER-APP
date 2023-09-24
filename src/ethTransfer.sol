//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

// display in and out ---- DONE
//let only the user show only the user details   ---- NOT DONE LMAO
// cannot send to yourself  ---- DONE 
// NON zero transaction ----- DONE
contract ethTransfer {


error NONZERO();
error YOU_CANT_SEND_ETHER_TO_SELF();

event transactionsent(address from, address to, uint256 amount,string description);


    struct transactionDetails {
        address from;
        address to;
        uint256 amount;
        string description;
    }
 transactionDetails  userDetails;
 transactionDetails[] public userHistory;
 uint256 public totalAmountOut;
 uint256 public  totalAmountIn = msg.sender.balance - totalAmountOut;

    function sendEth(address payable _to, string memory _description) payable public {
        if(msg.value == 0) {
            revert NONZERO();
        }
        else if(_to == msg.sender) {
            revert YOU_CANT_SEND_ETHER_TO_SELF();
        }
        else {
    _to.transfer((msg.value));
    totalAmountOut += msg.value;
    userHistory.push(transactionDetails({
        from: msg.sender,
        to:_to,
        amount:msg.value,
        description:_description

    })
    );
    emit transactionsent(msg.sender,_to,msg.value,_description);
        }
    }

function balanceOfUser() external view returns(uint256){
uint256 userBalance = msg.sender.balance;
return(userBalance);
}

    
}