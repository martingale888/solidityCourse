// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {UD60x18, ud, unwrap,powu} from "prb-math/UD60x18.sol";

contract LinearBondingCurve {
    /**
     * for simplicity, this is limited to y=mx, which is reflected in x1.sqrt()
     * purchaseReturn : TS *(1+ depositAmount/ReserveBalance)^ReserveRatio -1)
     * ReserveRatio = 1 / N_PLUS_1
     * ReserveRatio = 1/(n+1) = 0.5
     * n=1
     */

    function calculatePurchaseReturn(
        uint256 _supply,
        uint256 _reserveBalance,
        uint256 _N_PLUS_1,
        uint256 _depositAmount) public pure returns(uint256) {
            UD60x18 s = ud(_supply);
            UD60x18 r = ud(_reserveBalance);
            UD60x18 d = ud(_depositAmount);
            UD60x18 n_plus_1= ud(_N_PLUS_1);

            UD60x18 x1 = ud(1e18).add(d.div(r));
            UD60x18 x2 = (x1.sqrt()).sub(ud(1e18));
            UD60x18 ret = s.mul(x2);

            return unwrap(ret);
        }

    /**
     * Return = _reserveBalance * (1 - (1 - _sellAmount / _supply) ^ (1 / (_reserveRatio / MAX_RESERVE_RATIO)))
     * ReserveRatio = 1/(n+1) = 0.5
     * n=1
     */

    function calculateSaleReturn(
        uint256 _supply,
        uint256 _reserveBalance,
        uint256 _N_PLUS_1,
        uint256 _sellAmount) public pure returns(uint256) {
            UD60x18 s = ud(_supply);
            UD60x18 r = ud(_reserveBalance);
            UD60x18 sm= ud(_sellAmount);
            UD60x18 n_plus_1 = ud(_N_PLUS_1);
            
            UD60x18 x1 = ud(1e18).sub(sm.div(s));
            UD60x18 x2 = ud(1e18).sub(x1.powu(unwrap(ud(1e18).mul(n_plus_1))));
            UD60x18 ret = r.mul(x2);

            return unwrap(ret);
    }
}