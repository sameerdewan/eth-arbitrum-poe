//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "../node_modules/@openzeppelin/contracts/utils/Counters.sol";

contract ProofToken is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct Proof {
        bytes32 hashValue;
        bytes32 URIHash;
        bool exists;
        uint256 blockTimestamp;
    }

    mapping(bytes32 => Proof) public proofs;

    constructor() ERC721("ProofToken", "PROOF") {}

    event ProofTokenMinted(bytes32 indexed hashValue, bytes32 indexed URIHash, uint256 blockTimestamp);

    modifier doesNotExist(bytes32 _hashValue) {
        require(proofs[_hashValue].exists == false, "Proof with hash already exists");
        _;
    }

    function validate(bytes32 _hashValue) external view returns(bool) {
        return proofs[_hashValue].exists;
    }

    function mintProofToken(bytes32 _hashValue) external doesNotExist(_hashValue) {
        _tokenIds.increment();
        uint256 _tokenId = _tokenIds.current();
        _mint(msg.sender, _tokenId);
        _setTokenURI(_tokenId, "");
        uint256 blockTimestamp = block.timestamp;
        proofs[_hashValue] = Proof({
            hashValue: _hashValue,
            URIHash: "",
            exists: true,
            blockTimestamp: blockTimestamp
        });
        emit ProofTokenMinted(_hashValue, "", blockTimestamp);
    }

    function mintProofToken(bytes32 _hashValue, bytes32 _URIHash, string memory _URI) external doesNotExist(_hashValue) {
        _tokenIds.increment();
        uint256 _tokenId = _tokenIds.current();
        _mint(msg.sender, _tokenId);
        _setTokenURI(_tokenId, _URI);
        uint256 blockTimestamp = block.timestamp;
        proofs[_hashValue] = Proof({
            hashValue: _hashValue,
            URIHash: _URIHash,
            exists: true,
            blockTimestamp: blockTimestamp
        });
        emit ProofTokenMinted(_hashValue, _URIHash, blockTimestamp);
    }
}
