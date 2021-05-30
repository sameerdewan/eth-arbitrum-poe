# eth-arbitrum-poe
The eth-arbitrum-poe repository is free to fork and use by anyone, anytime.

ProofTokens are NFTs that are minted to represent proof of existence. The underlying contract for the ProofToken is written in Solidity, and can be deployed to any EVM friendly environment. The minter of a ProofToken _must_ provide the `mintProofToken()` function one parameter - a bytes32 hash of the item that a proof is being generated for, _and_ _two_ _optional_ _parameters_, a bytes32 hash of the item's off-chain URI resource, and a string of the off-chain resource.

_Example 1: Only bytes32 hash of desired item proof provided_

```javascript
async function mintProofToken(fileAsBuffer) {
    // assumes global constant for web3 deployed contract = "Contract"
    // assumes global hashing library "sha256"
    const hashValue = sha256(fileAsBuffer);
    const from = '0x07e07586A6433b65218f57010b026AbB66B7F2B2';
    await Contract.methods.mintProofToken(hashValue).send({ from })
    // The ProofToken NFT generated is sent to the sender
    // The contract emits an event "ProofTokenMinted"
}
```
