//SPDX-License-Identifier:MIT

pragma solidity 0.8.9;

contract Insta {
    struct user {
        string name;
        friend[] friendList;
        post[] SpeceficArray;
        message[] ArrayMessage;
        bool liked;
        bool postCreated;
    }

    struct post {
        string text;
        string imageUrl;
        address WhoCreatedPost;
        uint postAccount;
    }

    struct comment{
        string text;
    }

    struct friend {
        string name;
        address pubkey;
    }

    struct message{
        address pubkey;
        string message;
    }

    mapping(address => user) public ALLUser;
    mapping(address => post) public ALLPost;
    mapping (address => friend) public AllFriend;
    mapping (address => message) public AllMessage;
    post[] public AllPostArray;
    user[] public AllUserArray;
    uint256 TotalLike=0;
    
    function CreateUser(string memory _name) public {
        ALLUser[msg.sender].name = _name;
        ALLUser[msg.sender].postCreated==true;
        // AllUserArray.push(user(_name,friend[]   , post[] ,message[] ,true,true));
    }

    function like() public {
        require(ALLUser[msg.sender].postCreated=true);
                TotalLike++;
    }

    function createPost(address me ,string memory _text, string memory _imageUrl) public {
        require(ALLUser[msg.sender].postCreated=true);
        ALLPost[msg.sender].text = _text;
        ALLPost[msg.sender].imageUrl = _imageUrl;
        ALLPost[msg.sender].WhoCreatedPost = msg.sender;
        AllPostArray.push(post(_text, _imageUrl, msg.sender,TotalLike));
        ALLUser[me].SpeceficArray.push(post(_text,_imageUrl,msg.sender,TotalLike));
        ALLUser[msg.sender].liked==true;
    }


    function CreateFriend(address me ,address _pubkey , string memory _name) public {
        require(ALLUser[msg.sender].postCreated=true);
        AllFriend[_pubkey].pubkey=_pubkey;
        AllFriend[_pubkey].name=_name;
        friend memory newFriend = friend(_name,_pubkey);
        ALLUser[me].friendList.push(newFriend);
    }

    function createChat(address me , address _pubkey , string memory _message) public{
        message memory newMessage=message(_pubkey,_message);
        ALLUser[me].ArrayMessage.push(newMessage);
    }

    function sepecificLike() public view returns(uint) {
       return ALLPost[msg.sender].postAccount;
    }

    function speceficMessage() public view returns (message[] memory){
        return ALLUser[msg.sender].ArrayMessage;
    }

    function specificPost() public view returns(post[] memory) {
        return ALLUser[msg.sender].SpeceficArray;
    }

    function AllPostByEveryone() public view returns (post[] memory) {
        return AllPostArray;
    }

    function allUser() public view returns (user[] memory) {
        return AllUserArray;
    }

    function getMyFriendList() external view returns (friend[] memory) {
        return ALLUser[msg.sender].friendList;
    }
}

