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
