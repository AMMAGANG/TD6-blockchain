pragma solidity ^0.4.25;

import "./ERC721.sol";
import "./SafeMath.sol";

contract Pet_shop is ERC721 {

	using SafeMath for uint256;
	address private  mode; 
	
	struct Animal 
	{
		address owner; 
		string breed; 
		string name; 
		string color; 
		uint age;
		uint id; 
		bool alive; 
		uint genre; // 0 for a female, 1 for a male
	
	}
	
	 Animal[] public Animals;

    event RegisterBreed(address indexed account);
    event declaredAnimal(uint objectNumber);

    mapping (address => bool) private registerBreed;
    mapping (uint256 => address) private tokenOwner;
    modifier onlyOwner() {
        require(msg.sender == mode, "Owner 0x0");
        _;
	}

    function owner() public view returns (address) {
        return mode;
    }
	
	modifier isRegister(address _address) {
        require(registerBreed[_address], "not in registerBreed");
        _;
    }
	
	function addRegisterBreeder(address _address) public onlyOwner() 
	{
        require(!registerBreed[_address], "aldready in registerBreed");
        registerBreed[_address] = true;
        emit RegisterBreed(_address);
    }
	function isInRegister(address _address) public view returns (bool) {
        return registerBreed[_address];
    }
	
	 function declareAnimal(string breed, string name, string color, uint age, uint id, uint genre) public 
    {
        Animal memory Animal1;
        require(isInRegister(msg.sender));

        
		Animal1.breed = breed;
        Animal1.name = name;
        Animal1.color = color;
        Animal1.age = age;
        Animal1.id = id;
        Animal1.alive = true;
		Animal1.genre = genre; 

        Animals.push(Animal1) - 1;
        uint objectNumber = Animals.length - 1;
        tokenOwner[objectNumber] = msg.sender;
        emit declaredAnimal(objectNumber);
    }
	
	function deadAnimal(uint animalN) public {
        require(tokenOwner[animalN] == msg.sender);
        Animals[animalN].alive = false;
    }
	
	function compareString(string name1, string name2) private returns(bool)
	{
        if (uint(keccak256(abi.encodePacked(name1))) == uint(keccak256(abi.encodePacked(name2)))) {
            return true;
	    }
        else{
            return false;
	    }
	}
	
	function breedAnimal (uint animalId1, uint animalId2) public {
        require (msg.sender == owner);
        require (registerBreed[animalId1].genre != registerBreed[animalId2].genre);
        require (compareString(registerBreed[animalId1].breed, RegisterBreed[animalId2].breed)==true);
        string childBreed = registerBreed[animalId1].breed;
        string childColor = registerBreed[animalId1].color;
        declareAnimal(childBreed,"baba", childColor,0, 4, true, 1);
    }
}
