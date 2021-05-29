//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.0;

import "hardhat/console.sol";


contract PoE {

  struct Record {
    bytes32 hashValue;
    bool exists;
    uint blockTimestamp;
    string message;
    address signer;
  }

  mapping(bytes32 => Record) public hashValueToRecord;

  bytes32[] records;

  constructor() {}

  event RecordCreated(bytes32 indexed _hashValue, string indexed message, address indexed signer);

  modifier doesNotExistAlready(bytes32 _hashValue) {
      (, bool exists,) = this.get(_hashValue);
      require(exists == false, "Record already exists");
    _;
  }

  function get(bytes32 _hashValue) public view returns(bytes32, bool, uint) {
    Record memory record = hashValueToRecord[_hashValue];
    return (record.hashValue, record.exists, record.blockTimestamp);
  }

  function post(bytes32 _hashValue) external doesNotExistAlready(_hashValue) {
    (, bool exists,) = this.get(_hashValue);
    require(exists == false, "Record already exists");
    hashValueToRecord[_hashValue] = Record({
      hashValue: _hashValue,
      exists: true,
      blockTimestamp: block.timestamp,
      message: "N/A",
      signer: address(this)
    });
    records.push(_hashValue);
    emit RecordCreated(_hashValue, "N/A", address(this));
  }

  function post(bytes32 _hashValue, bool sign) external doesNotExistAlready(_hashValue)  {
    address signer = address(this);
    if (sign == true) {
      signer = msg.sender;
    }
    hashValueToRecord[_hashValue] = Record({
      hashValue: _hashValue,
      exists: true,
      blockTimestamp: block.timestamp,
      message: "N/A",
      signer: signer
    });
    records.push(_hashValue);
    emit RecordCreated(_hashValue, "N/A", address(this));
  }

  function post(bytes32 _hashValue, string memory message) external doesNotExistAlready(_hashValue)  {
    hashValueToRecord[_hashValue] = Record({
      hashValue: _hashValue,
      exists: true,
      blockTimestamp: block.timestamp,
      message: message,
      signer: address(this)
    });
    records.push(_hashValue);
    emit RecordCreated(_hashValue, message, address(this));
  }

  function post(bytes32 _hashValue, string memory message, bool sign) external doesNotExistAlready(_hashValue)  {
    address signer = address(this);
    if (sign == true) {
      signer = msg.sender;
    }
    hashValueToRecord[_hashValue] = Record({
      hashValue: _hashValue,
      exists: true,
      blockTimestamp: block.timestamp,
      message: message,
      signer: signer
    });
    records.push(_hashValue);
    emit RecordCreated(_hashValue, message, address(this));
  }
}