// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@redstone-finance/evm-connector/contracts/data-services/MainDemoConsumerBase.sol";
import "./Marketplace.sol";

/* 
  StableMarketplace contract should extend MainDemoConsumerBase contract
  For being able to use redstone oracles data, more inf:
  https://docs.redstone.finance/docs/smart-contract-devs/get-started/redstone-core#1-adjust-your-smart-contracts 
*/
contract StableMarketplace is Marketplace, MainDemoConsumerBase {
  /*
    `_getPriceFromOrder` function should uses the `getOracleNumericValueFromTxMsg` function,
    which fetches signed data from tx calldata and verifies its signature
  */ 
  function _getPriceFromOrder(
    SellOrder memory order
  ) internal view override returns (uint256) {
    uint256 ethPrice = getOracleNumericValueFromTxMsg(bytes32("ETH"));
    return (order.price / ethPrice) * (10 ** 8);
  }
}
