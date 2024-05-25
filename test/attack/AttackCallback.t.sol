// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../pool/Setup.t.sol";
import "../mocks/AttackCallbackContract.sol";

contract TestAttackCallback is TestPool {
    AttackCallbackContract private _attackContract; // Corrected typo
    uint256 private pairId; // Marked as private

    function setUp() public override {
        super.setUp(); // Corrected method call

        pairId = registerPair(address(currency1), address(0), false);

        predyPool.supply(pairId, true, 1e8);
        predyPool.supply(pairId, false, 1e8);

        _attackContract = new AttackCallbackContract(predyPool, address(currency1)); // Corrected typo
    }

    function testAttackCallback() public {
        assertEq(currency1.balanceOf(address(_attackContract)), 0);

        IPredyPool.TradeParams memory tradeParams = IPredyPool.TradeParams({
            pairId: pairId,
            tradeType: 0,
            quantity: 0,
            price: 0,
            data: bytes("0x")
        });

        vm.expectRevert(bytes("ReentrancyGuard: reentrant call"));
        _attackContract.trade(tradeParams);

        assertEq(currency1.balanceOf(address(_attackContract)), 0);
    }
}
