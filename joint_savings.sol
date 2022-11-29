pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    /*
    Define the following variables in the new contract:
      - Two variables of type `address payable` named `accountOne` and `accountTwo`
      - A variable of type `address public` named `lastToWithdraw`
      - Two variables of type `uint public` named `lastWithdrawAmount` and `contractBalance`
    */
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    /*
    Define a function named `withdraw` that accepts two arguments:
      - An `amount` of type `uint`
      - A `recipient` of type `payable address`
    */
    function withdraw(uint amount, address payable recipient) public {

        /*
        Define a `require` statement that checks if `recipient` is equal to either `accountOne` or `accountTwo`. If it isn't, the `require` statement returns the "You don't own this account!" text
        */
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        /*
        Define a `require` statement that checks if `balance` is sufficient for accomplishing the withdrawal operation. If there are insufficient funds, it returns the "Insufficient funds!" text
        */
        require(amount <= contractBalance, "Insufficient funds!");

        /*
        Add an `if` statement to check if `lastToWithdraw` is not equal to (`!=`) to `recipient`. If it's not equal, set it to the current value of `recipient`
        */
        if (lastToWithdraw != recipient) {
          lastToWithdraw = recipient;
        }

        // Call the `transfer` function of the `recipient` and pass it the `amount` to transfer as an argument
        recipient.transfer(amount);

        // Set  `lastWithdrawAmount` equal to `amount`
        lastWithdrawAmount = amount;

        // Set the `contractBalance` variable equal to the balance of the contract by using `address(this).balance` to reflect the new balance of the contract
        contractBalance = address(this).balance;
    }

    // Define a `public payable` function named `deposit`
    function deposit() public payable {

        /*
        Set the `contractBalance` variable equal to the balance of the contract by using `address(this).balance`
        */
        contractBalance = address(this).balance;
    }

    /*
    Define a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    */
    function setAccounts(address payable account1, address payable account2) public{

        // Set the values of `accountOne` and `accountTwo` to `account1` and `account2`, respectively
        accountOne = account1;
        accountTwo = account2;
    }

    /*
    Add a fallback function so that your contract can store ether that's sent from outside the deposit function
    */
    function() external payable {}
}
