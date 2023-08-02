// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.19 <0.9.0;

import { PRBTest } from "@prb/test/PRBTest.sol";
import { console2 } from "forge-std/console2.sol";
import { StdCheats } from "forge-std/StdCheats.sol";

import { Registry } from "../src/Registry.sol";


contract RegistryTest is PRBTest, StdCheats {
    Registry internal registry;

    /// @dev A function invoked before each test case is run.
    function setUp() public virtual {
        // Instantiate the contract-under-test.
        registry = new Registry(address(this));
    }

    /// @dev Basic test. Run it with `forge test -vvv` to see the console log.
    function test_all() external {
        console2.log("Set");
        registry.set("uint256", abi.encode(uint256(1)));
        assertEq(abi.decode(registry.get("uint256"), (uint256)), 1);

        registry.set("(uint256,uint256)", abi.encode(uint256(1), uint256(2)));
        (uint256 a, uint256 b) = abi.decode(registry.get("(uint256,uint256)"), (uint256, uint256));
        assertEq(a, 1);
        assertEq(b, 2);

        registry.set("bool", abi.encode(true));
        assertEq(abi.decode(registry.get("bool"), (bool)), true);

        registry.set("address", abi.encode(address(1)));
        assertEq(abi.decode(registry.get("address"), (address)), address(1));

        registry.set("bytes", abi.encode(bytes("hello")));
        assertEq(abi.decode(registry.get("bytes"), (bytes)), bytes("hello"));

        registry.set("string", abi.encode(string("hello")));
        assertEq(abi.decode(registry.get("string"), (string)), string("hello"));
    }
}
