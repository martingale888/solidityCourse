

contract stringBytes{

    string public foo;
    bytes32 public bar;

    function main() public {
        foo = "hello";
    }

    function readInAssembly() public {
        assembly{
            a := slod(0)
            b := sload(1)
        }
    }
}
