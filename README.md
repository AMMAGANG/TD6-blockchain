# TD6-blockchain

C'est Oscar GRAND MIF7


 creation of a ERC271 contract and implementation of all the functions. 
 
 Creation of a registerBreeder() function : 
 
 event RegisterBreed(address indexed account);
 
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
    
    declaration of an animal : 
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
    
    
    DeadAnimal Function : 
    
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
  
  breedAnimal Funtion: 
  
  function breedAnimal (uint animalId1, uint animalId2) public {
        require (msg.sender == owner);
        require (registerBreed[animalId1].genre != registerBreed[animalId2].genre);
        require (compareString(registerBreed[animalId1].breed, RegisterBreed[animalId2].breed)==true);
        string childBreed = registerBreed[animalId1].breed;
        string childColor = registerBreed[animalId1].color;
        declareAnimal(childBreed,"baba", childColor,0, 4, true, 1);
    }
}
