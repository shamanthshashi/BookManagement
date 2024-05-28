# BookStore Smart Contract
This Solidity smart contract implements a simple book store management system on the Ethereum blockchain. The contract allows the owner to add books to the store, and users to purchase books by sending the required amount of Ether. The contract tracks book inventory and user purchases.

## Features
- Add Books: The owner can add new books to the store by specifying the title, author, price, and stock quantity.
- Purchase Books: Users can purchase books by sending the correct amount of Ether.
- Track Inventory: The contract maintains the inventory of books and updates the stock after each purchase.
- Track Purchases: The contract keeps a record of the quantity of each book purchased by each user.

## Error Handling
- Owner Restrictions:
Only the contract owner can add books to the store. This is enforced using the require statement.
- Validations:
The contract validates that the price and stock are greater than zero when adding a book.
- Stock Availability:
The contract ensures that the requested quantity is available in stock before processing a purchase.
- Payment Verification:
The contract verifies that the correct amount of Ether is sent with the purchase transaction.

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., BookManagement.sol). Copy and paste the following code into the file:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BookStore {
    address public owner=msg.sender;

    struct Book {
        uint id;
        string title;
        string author;
        uint price;
        uint stock;
    }

    uint public nextBookId;
    mapping(uint => Book) public books;
    mapping(address => mapping(uint => uint)) public purchases;

    function addBook(string memory _title, string memory _author, uint _price, uint _stock) public  {
        require(msg.sender == owner, "Only owner can perform this action");
        assert(_price>0 && _stock>0);
        books[nextBookId] = Book(nextBookId, _title, _author, _price, _stock);
        nextBookId++;
    }

    function purchaseBook(uint _bookId, uint _quantity) public payable {
        Book storage book = books[_bookId];
        require(_quantity > 0, "Quantity must be greater than zero");
        if(_quantity >= book.stock){
            revert("Not enough stock available");
        } 
        assert(msg.value == book.price * _quantity);
        book.stock -= _quantity;
        purchases[msg.sender][_bookId] += _quantity;
    }
}

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.0" (or another compatible version), and then click on the "Compile BookManagement.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "BookManagement" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it .
## Authors

Shamanth Shashikumar

[shamanthshashi2@gmail.com]

## License

This project is licensed under the [MIT] License - see the LICENSE.md file for details
