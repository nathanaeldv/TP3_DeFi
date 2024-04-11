// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function testIncrement() public {
        counter.increment();
        assertEq(counter.number(), 1, "Number should be incremented to 1");
    }

    function testFuzzSetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x, "Number should be set to x");
    }
}
