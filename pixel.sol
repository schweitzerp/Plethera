pragma solidity ^0.4.25;

import "./ownable.sol";
import "./safemath.sol";

contract Plethera is Ownable {
  
  //each Pixel object stores it's linear location and color in 3 byte RGB
  struct Pixel{
  	bytes4 color;
  	uint8 _pixelNum
  }

  event newPixel(_pixel, _color);

  //the whole picture object is an array of these pixels and is called picture
  Pixel[] public picture;

  mapping (uint => address) public pixelToOwner;
  mapping (address => uint) ownerPixelCount;

  //checks that the user owns the pixel to be changed (update when canvas size finalized)
  modifier onlyOwnerOf(uint8 _pixelNum){
  	require(msg.sender == pixelToOwner[_pixelNum]);
  	_;
  }
  
  //change the color of the pixel using _pixelNum as the array location
  /*!! Need to ensure that each array item stays in the same order when they're modified
    so that we can just store an array of colors and use the order in the array as the pixel location*/
  function setColor(uint8 _pixelNum, bytes4 _color) public onlyOwnerOf{
  	picture[_pixelNum].color = _color;
  }

  //set all pixels to white with no transparency
  constructor() internal{
  	for(i=0, i< 25, i++){
  		setColor(i, 0);
  	}
  }
}
