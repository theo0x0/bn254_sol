// SPDX-License-Identifier: MIT
pragma solidity >=0.8.25;

contract EcHelper {

    struct Point {
        uint256 x;
        uint256 y;
    }

    Point G_1 = Point({x: 1, y: 2});
    Point G_2 = Point({x: 11289777278598793225085907404653984148857981139181946850122111571098664312074, y: 4216647052951083135303109263368671021502984236462818053005360266128784521345});
    uint256 constant field = 21888242871839275222246405745257275088548364400416034343698204186575808495617;

    function ec_add(Point memory p_1, Point memory p_2) public view returns(Point memory) {
        (bool ok, bytes memory result) = address(6).staticcall(abi.encode(p_1.x, p_1.y, p_2.x, p_2.y));
        require(ok, "Ec Add error");

        (uint256 x, uint256 y) = abi.decode(result, (uint256, uint256));
        return Point({x: x, y: y});
    }

    function ec_mul(Point memory p, uint256 s) public view returns(Point memory) {
        (bool ok, bytes memory result) = address(7).staticcall(abi.encode(p.x, p.y, s));
        require(ok, "Ec Mul error");

        (uint256 x, uint256 y) = abi.decode(result, (uint256, uint256));
        return Point({x: x, y: y});
    }


    function ec_mul_points_scalars(Point[] memory P, uint256[] memory s) public view returns(Point memory) {
        require(P.length == s.length, "Wrong arrays length");
        Point memory Res = Point({x: 0, y: 0});

        for(uint256 i = 0; i < P.length; i++) {
            require(s[i] != 0, "Wrong scalar mul");
            Res = ec_add(Res, ec_mul(P[i], s[i]));
        }

        return Res;
    }

    function ec_add_points_point(Point[] memory P, Point memory P_2) internal view {

        for(uint i = 0; i < P.length; i++) {
            P[i] = ec_add(P[i], P_2);
        }

    }

}

contract MathHelper is EcHelper {

    function sum(uint256[] memory arr) internal pure returns(uint256) {
        uint256 res;

        for(uint i = 0; i < arr.length; i++) {
            res = addmod(res, arr[i], field);
        }

        return res;
    }

}


contract HashHelper is EcHelper {

    function hash_points(Point[] memory S, Point memory S_1) pure public returns (uint256) {
        return uint256(keccak256(abi.encode(S, S_1)));
    }

}
