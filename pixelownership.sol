pragma solidity ^0.4.25;

import "./pixel.sol";
import "./erc721.sol";
import "./safemath.sol";

contract PixelOwnership is pixel, ERC721{
	using SafeMath for uint8;

	mapping (uint8=> address) pixelApprovals; 

	//
	

/* COPIED BLOCK OF CODE FROM CRYPTOZOMBIES STARTS HERE*/
	function balanceOf(address _owner) external view returns (uint256) {
    	return ownerPixelCount[_owner];
  	}

  	function ownerOf(uint256 _tokenId) external view returns (address) {
    	return PixelToOwner[_tokenId];
  	}

  	function _transfer(address _from, address _to, uint256 _tokenId) private {
    	ownerPixelCount[_to] = ownerPixelCount[_to].add(1);
    	ownerPixelCount[msg.sender] = ownerPixelCount[msg.sender].sub(1);
    	PixelToOwner[_tokenId] = _to;
    	emit Transfer(_from, _to, _tokenId);
  	}

  	function transferFrom(address _from, address _to, uint256 _tokenId) external payable {
      	require (PixelToOwner[_tokenId] == msg.sender || pixelApprovals[_tokenId] == msg.sender);
      	_transfer(_from, _to, _tokenId);
    }

  	function approve(address _approved, uint256 _tokenId) external payable onlyOwnerOf(_tokenId) {
      	pixelApprovals[_tokenId] = _approved;
      	emit Approval(msg.sender, _approved, _tokenId);
    }
}