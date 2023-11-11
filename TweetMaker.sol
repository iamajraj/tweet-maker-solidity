// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;


contract TwitterClone {
    uint256 internal tweetIdCounter = 0;
    struct Profile {
        address user_address;
        string user_name;
        uint256 tweetsCount;        
    }
    struct Tweet {
        uint256 id;
        string content;
        address tweetBy;
        address[] likes;
    }

    mapping(address => Profile) public userProfiles;
    Profile[] public profiles;
    Tweet[] public userTweets;

    function setProfile(string memory name) public {
        Profile memory profile = Profile(msg.sender, name, 0);
        userProfiles[msg.sender] = profile;
        profiles.push(profile);
    }

    function createTweet(string memory content) public {
        address[] memory likes;
        Tweet memory tweet = Tweet(tweetIdCounter, content, msg.sender, likes);
        userTweets.push(tweet);
        tweetIdCounter++;
        userProfiles[msg.sender].tweetsCount += 1;
    }

    function likeTweet(uint256 id) public {
        for(uint256 i = 0; i < userTweets.length; i++){
            if(userTweets[i].id == id){
                userTweets[i].likes.push(msg.sender);
            }
        }
    }
}