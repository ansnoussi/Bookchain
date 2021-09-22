pragma solidity >=0.4.21 <0.7.0;

import './Ownable.sol';

contract Bookchain is Ownable {

  struct Book {
    bytes32 recordHash;
    bytes32 authorName;
    bytes32 title;
    bytes32 email;
    uint timestamp;
    bool isDocExists;
  }

  mapping(bytes32 => Book) public documentdata;

  event _NewBookAuth(bytes32 indexed recordHash, bytes32 authorName, bytes32 title, bytes32 email, uint256 timestamp, bool isDocExists);

  function authNewBook(bytes32 recordHash, bytes32 authorName, bytes32 title, bytes32 email) external {

    require(recordHash != "");

    Bookchain.Book storage bookdata = documentdata[recordHash];
    bookdata.recordHash = recordHash;
    bookdata.authorName = authorName;
    bookdata.title = title;
    bookdata.email = email;
    bookdata.timestamp = block.timestamp;
    bookdata.isDocExists = true;

    emit _NewBookAuth(recordHash, authorName, title, email, block.timestamp, true);
  }


  function exists(bytes32 record) view public returns(bool) {
    return documentdata[record].isDocExists;
  }

  function getBookDetailFromHash(bytes32 record) view public returns ( bytes32,bytes32,bytes32,uint256) {
    return  ( documentdata[record].authorName , documentdata[record].title, documentdata[record].email, documentdata[record].timestamp );
  }

}