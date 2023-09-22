// SPDX-License-Identified: MIT
pragma solidity ^0.8.18;

contract SimpleStorage{
//   bool hasFavouriteNumber = true;
//   string favouriteNumberInText ="88";
//   int256 favouriteInt = -88;
//   address myAddress = 0xcdac7F8840EDec963D7b09CE9d8FAD9295eCB8A6;
//   bytes32 favoriteButes32 = "cat";
  uint256 myFavouriteNumber = 88;
  uint256[] listOfFavoriteNumbers;

    struct Person{
        uint256 favoriteNumber;
        string name;
    }

    // Person public myFried = Person({favoriteNumber: 7, name: "Kiril"});
    // Person public myFried2 = Person({favoriteNumber: 17, name: "Ivan"});

    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavoriteNumber;

    uint testVar;
    function store(uint256 _favoriteNumber) public{
        myFavouriteNumber = _favoriteNumber;
         testVar = 5;
    }

    function something() public {
        testVar = 6;
        myFavouriteNumber = 7;
    }

    // view is read only, pure return values only not variables
    function retrieve() public view returns(uint256){
        return myFavouriteNumber;
    }

    // calldata temp var cannot be modified, memory exist only during execution call, storage 
    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        Person memory newPerson = Person(_favoriteNumber, _name);
        listOfPeople.push(newPerson);
        nameToFavoriteNumber[_name] = _favoriteNumber;

    }
}

