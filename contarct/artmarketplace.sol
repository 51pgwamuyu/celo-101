// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IERC20Token {
    function transfer(address, uint256) external returns (bool);
    function approve(address, uint256) external returns (bool);
    function transferFrom(address, address, uint256) external returns (bool);
    function totalSupply() external view returns (uint256);
    function balanceOf(address) external view returns (uint256);
    function allowance(address, address) external view returns (uint256);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract Art {
    uint256 private artCount = 0;
    address payable public cUsdTokenAddress;

    constructor(address _cUsdTokenAddress) {
        cUsdTokenAddress = payable(_cUsdTokenAddress);
    }

    struct Artwork {
        address payable owner;
        string name;
        string imageUrl;
        string description;
        uint256 price;
    }

    struct Comment {
        address user;
        string content;
        uint256 timestamp;
    }

    struct Like {
        address user;
    }

    mapping(uint256 => Artwork) private arts;
    mapping(uint256 => Comment[]) private _comments;
    mapping(uint256 => Like[]) private _likes;

    event ArtworkCreated(uint256 indexed artworkId, address indexed owner, string name);
    event ArtworkDeleted(uint256 indexed artworkId, address indexed owner, string name);
    event CommentAdded(uint256 indexed artworkId, address indexed user, string content);
    event LikeAdded(uint256 indexed artworkId, address indexed user);

    modifier onlyOwner(uint256 _artId) {
        require(msg.sender == arts[_artId].owner, "Only owner is permitted to do so");
        _;
    }

    modifier validArtId(uint256 _artId) {
        require(_artId < artCount, "Invalid art ID");
        _;
    }

    function uploadArtwork(
        string memory _name,
        string memory _imageUrl,
        string memory _description,
        uint256 _price
    ) public {
        require(bytes(_name).length > 0, "Artwork name is required");
        require(bytes(_imageUrl).length > 0, "Artwork image URL is required");
        require(bytes(_description).length > 0, "Artwork description is required");
        require(_price > 1, "Artwork price must be greater than 1 Celo");

        arts[artCount] = Artwork({
            owner: payable(msg.sender),
            name: _name,
            imageUrl: _imageUrl,
            description: _description,
            price: _price
        });
        emit ArtworkCreated(artCount, msg.sender, _name);
        artCount++;
    }

    function getArtDetails(uint256 _artId)
        public
        view
        validArtId(_artId)
        returns (
            address,
            string memory,
            string memory,
            string memory,
            uint256
        )
    {
        Artwork memory art = arts[_artId];
        return (
            art.owner,
            art.name,
            art.description,
            art.imageUrl,
            art.price
        );
    }

    function deleteArt(uint256 _artId) public onlyOwner(_artId) validArtId(_artId) {
        emit ArtworkDeleted(_artId, msg.sender, arts[_artId].name);
        delete arts[_artId];
    }

    function buyArt(uint256 _artId) public payable validArtId(_artId) {
        Artwork storage art = arts[_artId];
        require(IERC20Token(cUsdTokenAddress).transferFrom(msg.sender, art.owner, art.price), "Transfer failed.");
        art.owner = payable(msg.sender);
    }

    function addComment(uint256 _artId, string memory _content) public validArtId(_artId) {
        require(bytes(_content).length > 0, "Comment content is required");

        _comments[_artId].push(
            Comment({
                user: msg.sender,
                content: _content,
                timestamp: block.timestamp
            })
        );
        emit CommentAdded(_artId, msg.sender, _content);
    }

    function getComments(uint256 _artId) public view validArtId(_artId) returns (Comment[] memory) {
        return _comments[_artId];
    }

    function addLike(uint256 _artId) public validArtId(_artId) {
        _likes[_artId].push(Like({user: msg.sender}));
        emit LikeAdded(_artId, msg.sender);
    }
}
