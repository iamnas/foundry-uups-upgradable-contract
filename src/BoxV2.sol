// SPDX-License-Identifier: MIT 
// SPDX-License-Identifire: MIT

pragma solidity 0.8.24;

contract BoxV2 {

    uint256 internal number;

    function setNumber(uint256 _number) external {
        number = _number;
    }

    function getNumber() external view returns(uint256 ){
        return number;
    }

    function getVersion() external pure returns(uint8) {
        return 2;
    }
    
}
