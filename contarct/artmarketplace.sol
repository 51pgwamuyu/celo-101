// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IERC20Token {
    function transfer(address, uint256) external returns (bool);

    function approve(address, uint256) external returns (bool);

    function transferFrom(
        address,
        address,
        uint256
    ) external returns (bool);

    function totalSupply() external view returns (uint256);

    function balanceOf(address) external view returns (uint256);

    function allowance(address, address) external view returns (uint256);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
}

contract art {
    uint256 internal artsLength = 0;
    address internal cUsdTokenAddress =
        0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1;

    constructor(address _cUsdTokenAddress) {
        cUsdTokenAddress = _cUsdTokenAddress;
    }

    struct Art {
        address payable owner;
        string artName;
        string artimageurl;
        string artdescription;
        uint256 artprice;
    }
    struct Comment {
        address user;
        string content;
        uint256 timestamp;
    }

    struct Like {
        address user;
    }

    // mapping to store payee details
    mapping(uint256 => Art) internal arts;
    mapping(uint256 => Comment[]) internal _comments;
    mapping(uint256 => Like[]) internal _likes;

    event CommentAdded(
        uint256 indexed artworkId,
        address indexed user,
        string content
    );
    event LikeAdded(uint256 indexed artworkId, address indexed user);
 event artCreated(
    uint256 indexed  artid, address indexed  owner,string artname
 );
  event artDeleted(
    uint256 indexed  artid, address indexed  owner,string artname
 );
    // Function to create a payee.
    function uploadAnArt(
        string memory _artname,
        string memory _artimage,
        string memory _artdescription,
        uint256 _artprice
    ) public {
        require(bytes(_artname).length > 0, "art name is required");
        require(bytes(_artimage).length > 0, "artimage is required");
        require(bytes(_artdescription).length > 0, "artdecription is required");
        require(_artprice > 1, "the price of art must be greater than 1 celo");

        arts[artsLength] = Art({
            owner: payable(msg.sender),
            artName: _artname,
            artimageurl: _artimage,
            artdescription: _artdescription,
            artprice: _artprice
        });
          emit artCreated(artsLength, msg.sender, _artname);
        artsLength++;
    }

    // get an art by detailas.
    function getArtDetails(uint256 _id)
        public
        view
        returns (
            address,
            string memory,
            string memory,
            string memory,
            uint256
        )
    {
        return (
            arts[_id].owner,
            arts[_id].artName,
            arts[_id].artdescription,
            arts[_id].artimageurl,
            arts[_id].artprice
        );
    }

    // owner delete an art
    function deleteArt(uint256 id) public {
        require(
            msg.sender == arts[id].owner,
            "Only owner is permitted to do so"
        );

        // Shift remaining payees down in the mapping
        for (uint256 i = id; i < artsLength - 1; i++) {
            arts[i] = arts[i + 1];
        }

        // Delete the last element in the mapping
        delete arts[artsLength - 1];
         emit artDeleted(artsLength, msg.sender, arts[artsLength].artName);
       
        artsLength--;
    }

    //get all arts
    // function to fund a payee
    function buyArt(uint256 _index) public payable {
        require(
            IERC20Token(cUsdTokenAddress).transferFrom(
                msg.sender,
                arts[_index].owner,
                arts[_index].artprice
            ),
            "Transfer failed."
        );
    }

    function addComment(uint256 artworkId, string memory content) public {
        _comments[artworkId].push(
            Comment(msg.sender, content, block.timestamp)
        );
        emit CommentAdded(artworkId, msg.sender, content);
    }

    function getComments(uint256 artworkId)
        public
        view
        returns (Comment[] memory)
    {
        return _comments[artworkId];
    }

    function addLike(uint256 artworkId) public {
        _likes[artworkId].push(Like(msg.sender));
        emit LikeAdded(artworkId, msg.sender);
    }
}
