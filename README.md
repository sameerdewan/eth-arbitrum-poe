# eth-arbitrum-poe
The eth-arbitrum-poe repository is free to fork and use by anyone, anytime.

ProofTokens are NFTs that are minted to represent proof of existence. The underlying contract for the ProofToken is written in Solidity, and can be deployed to any EVM friendly environment. The minter of a ProofToken _must_ provide the `mintProofToken()` function one parameter - a bytes32 hash of the item that a proof is being generated for, _and_ _two_ _optional_ _parameters_, a bytes32 hash of the item's off-chain URI resource, and a string of the off-chain resource.

_Example 1: Only bytes32 hashValue of desired item proof provided_
```javascript
async function mintProofToken(fileAsBuffer) {
    // assumes global constant for web3 deployed contract = "Contract"
    // assumes global hashing library "sha256"
    // The ProofToken NFT generated is sent to the sender
    // The contract emits an event "ProofTokenMinted"
    const hashValue = sha256(fileAsBuffer);
    const from = '0x07e07586A6433b65218f57010b026AbB66B7F2B2';
    await Contract.methods.mintProofToken(hashValue).send({ from });
}
```
_Example 2A: All three parameters provided (hashValue, URIHash, URI)_
```javascript
async function mintProofToken(fileAsBuffer) {
    const hashValue = sha256(fileAsBuffer);
    const URIHash = '01ec6108ec8c21ca933f0ee001b1b202';
    const URI = 'https://www.example.com/path/to/metadata.json';
    const args = [hashValue, URIHash, URI];
    const from = '0x07e07586A6433b65218f57010b026AbB66B7F2B2';
    await Contract.methods.mintProofToken(...args).send({ from });
}
```

_Example 2B: All three parameters provided (hashValue, URIHash, URI), but attaching an X12 EDI formatted basic invoice as the URI parameter, storing it on chain in the tokenURI field for the ERC721_
```javascript
async function mintProofToken(fileAsBuffer) {
    const hashValue = sha256(fileAsBuffer);
    const x12EDI = 'ST*810*0001~BIG*20000513*SG427254*20000506*508517*1001~N1*ST*ABC AEROSPACE CORPORATION*9*123456789-0101~N3*1000 BOARDWALK DRIVE~N4*SOMEWHERE*CA*98898~ITD*05*3*****30*******E~IT1*1*48*EA*3**MG*R5656-2~TDS*14400~CTT*1~SE*10*0001~';
    const x12EDIHash = sha256(x12EDI);
    const args = [hashValue, x12EDI, x12EDIHash];
    const from = '0x07e07586A6433b65218f57010b026AbB66B7F2B2';
    await Contract.methods.mintProofToken(...args).send({ from });
}
```
Source: https://x12.org/examples/004010x348/example-1-basic-invoice
