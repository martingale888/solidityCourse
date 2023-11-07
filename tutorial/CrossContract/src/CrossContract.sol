// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CrossContract {
    /**
     * The function below is to call the price function of PriceOracle1 and PriceOracle2 contracts 
     * below and return the lower of the two prices
     */

    function getLowerPrice(address _priceOracle1,address _priceOracle2) external returns (uint256) {
        // your code here
        (bool ok1, bytes memory p1byte) = _priceOracle1.call(abi.encodeWithSignature("price()"));
        (bool ok2, bytes memory p2byte) = _priceOracle2.call(abi.encodeWithSignature("price()"));
        require(ok1, "price1 call failed");
        require(ok2, "price2 call failed");
        uint256 p1 = abi.decode(p1byte,(uint256));
        uint256 p2 = abi.decode(p2byte,(uint256));
        if (p1 < p2){
            return p1;
        }else{
            return p2;
        }
    }
}

contract PriceOracle1 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}

contract PriceOracle2 {
    uint256 private _price;

    function setPrice(uint256 newPrice) public {
        _price = newPrice;
    }

    function price() external view returns (uint256) {
        return _price;
    }
}
