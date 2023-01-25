# <p align="center">GameBox


<p align="center">
<img src="https://img.shields.io/badge/Swift-5-red" />
<img src="https://img.shields.io/badge/Xcode-12.4-blue" />
<img src="https://img.shields.io/badge/iOS-14.4-yellow" />
<img src="https://img.shields.io/badge/Alamofire-5.6-orange" />
<img src="https://img.shields.io/badge/Kingfisher-6.3.1-green" />
<img src="https://img.shields.io/badge/DropDown-2.3-white" />
<img src="https://img.shields.io/badge/Cosmos-23.0-blackblue" />
<img src="https://img.shields.io/badge/NVActivityIndicatorView-5.1.1-pink" />

This project is prepared within the scope of SIMPRA iOS Bootcamp by Halil Ibrahim Andiç. You can browse between thousands of games, search, favorite or take notes about them. 

## Table of Contents

* [Movie](https://github.com/HalilIbrahimAndic/GameBox#Movie)
* [App Features](https://github.com/HalilIbrahimAndic/GameBox#App-Features)
* [Technical Content](https://github.com/HalilIbrahimAndic/GameBox#Technical-Content)
* [Libraries](https://github.com/HalilIbrahimAndic/GameBox#Libraries)
* [App Icon](https://github.com/HalilIbrahimAndic/GameBox#App-Icon)
* [Screenshots](https://github.com/HalilIbrahimAndic/GameBox#Screenshots)
* [Storyboard Map](https://github.com/HalilIbrahimAndic/GameBox#Storyboard-Map)


## Movie
https://user-images.githubusercontent.com/77022411/214521269-6ab4aebc-2ca2-4107-9d91-3cb137654743.mov


## App Features
- [x] List Games
  - Search by Game Name
  - Filter by released in 2022
  - Filter by Genre: RPG Games
  - Filter by Tag: Co-op Games
  - Filter by Platform: Mac-Os Games
- [x] Favorite Games List
  - Add games to Favorites
  - Remove games from Favorites
- [x] Notes List
  - Take and update notes about games
  - Delete notes
- [x] Language Support
  - English
  - Turkish
- [x] Performs Without Internet (Only Fetched)
 
  
## Technical Content
- [x] MVVM Architecture
- [x] Core Data
  - View previously listed games offline
  - View your favorite games offline
  - View your notes offline
- [x] Pagination
- [x] Image Cache
- [x] Local Notifications
- [x] Localization
- [x] Internet Connection Control


## Libraries
* Alamofire
* KingFisher
* DropDown
* Cosmos
* NVActivityIndicatorView

## App Icon
![GameBox](https://user-images.githubusercontent.com/77022411/214443612-43b1cea4-5346-4db6-8e33-287c340726fb.png)

Designed by my lovely wife, Didem <3


## Screenshots

|Screen|Description|
|---|---|
|![permission](https://user-images.githubusercontent.com/77022411/214450307-2d03733d-9b4f-4d32-9b61-514258b15814.png)|Permission request to send local notification|
|![gamelist](https://user-images.githubusercontent.com/77022411/214509013-e162a58d-1b2f-4aee-9876-b1c6e1200a65.png)|Home Page|
|![swipeAction](https://user-images.githubusercontent.com/77022411/214509031-af2d79bb-257c-44e2-904d-8833fccf3c37.png)|You can manage favorite and note taking actions from game list by swiping cell.|
|![favorites_empty](https://user-images.githubusercontent.com/77022411/214509008-fb0a0f35-4c0c-4d14-b536-eba01110b696.png)|Favorites Page (Empty)|
|![notes_empty](https://user-images.githubusercontent.com/77022411/214509018-d2076c0f-4ea0-46b1-940e-a446d08e9ff2.png)|Notes Page (Empty)|
|![detail](https://user-images.githubusercontent.com/77022411/214509004-d399cfe8-6071-49f5-b36a-a2ee2cf4b678.png)|Detail Page|
|![heart](https://user-images.githubusercontent.com/77022411/214510723-2faafc19-3f48-4f23-8aaf-f57af786dbed.png)|You can favorite any game by clicking the heart icon on its detail page|
|![favorites_filled](https://user-images.githubusercontent.com/77022411/214509010-6f516995-686d-48a8-9e3e-0690b9d3cfca.png)|Favorites Page (Filled)|
|![noteAlert](https://user-images.githubusercontent.com/77022411/214509014-9cec21d0-4b89-41ef-b6c4-97d5b0234bb7.png)|Note detail page will not allow you to save the note without filling all fields|
|![notification](https://user-images.githubusercontent.com/77022411/214509022-9f7d4a67-a7fb-41d1-acdd-81f7effe008f.png)|When the note saved successfully, a notification pops-up on the banner|
|![notificationList](https://user-images.githubusercontent.com/77022411/214511900-a3550cd5-e6f5-467b-b474-b0423cc579ab.png)|Same notification on Lock Screen|
|![notesFilled](https://user-images.githubusercontent.com/77022411/214509019-f8840dde-725a-4cec-a8c3-cf02db4caf73.png)|Notes Page (Filled)|
|![deleteOne](https://user-images.githubusercontent.com/77022411/214509002-85013229-c0c7-46af-8118-3a76149377df.png)|Delete a note or favorited game with swipe action|
|![deleteAll](https://user-images.githubusercontent.com/77022411/214508999-9d90933f-ad2e-480a-b53b-45f523249e8b.png)|Delete all of the notes or favorited games by clicking trash icon (top left)|
|![search](https://user-images.githubusercontent.com/77022411/214509024-dd7c92ae-0617-4d8c-9d0e-a7ad89160c2c.png)|You can search a game|
|![sortMenu](https://user-images.githubusercontent.com/77022411/214509027-3a99e751-8f28-4574-9cb5-7ff9a310fc29.png)|Open filter dropdown menu from top right icon and change game listing preferences|
|![activityIndicator](https://user-images.githubusercontent.com/77022411/214508993-dfb80785-ad10-48a2-b3a3-03c1f2f2d028.png)|Pacman indicator appears during fetch operation|


## Storyboard Map

![storyboard](https://user-images.githubusercontent.com/77022411/214452589-e6e05b3f-ebdf-40f2-916a-34c7dd6666c0.png)

