# Bn254 helper

These functions are using build in [contracts](https://www.evm.codes/precompiled)

**Structures:**
>struct Point 
>{
uint256 x;
uint256 y; 
}

**EcHelper operations:**
- Add two points over the curve `ec_add(Point memory, Point memory) returns Point`

- Multiply point over a scalar `ec_mul(Point memory,  uint256) returns Point` 

- Multiply an array of points over an array of scalars and **sum** them `ec_mul_points_scalars(Point[]  memory,  uint256[]  memory) returns Point`
**Requires** every scalar > 0 and same array lengths 

 - Add a point to array of points `ec_add_points_point(Point[]  memory, Point memory)`
 **Doesn't** return, modifies the same array

**MathHelper operations:**

- Sum of scalars over field `sum(uint256[]  memory) returns uint256`
Field is defined by bn254

**HashHelper operations:**

- Hashes an array of points appending one point `hash_points(Point[]  memory, Point memory) returns uint256`
Hash is keccak256. Data is encoded by `abi.encode()`
