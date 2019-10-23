# Geoguess iOS App
Inspired by the famous Geoguessr game, this iOS app shows user a street view of a city, and then the user needs to choose where it is from a list of options.

## Demo of the game
After starting a new game, a google street view of a city will be displayed. 
Clicking on the button "I know where this is" will lead the user to a multiple-choice question page. 4 cities will be listed along with their countries. After submitting a selction, the correct answer will be shown.
Each game contains five rounds, or five places to guess. After finishing all the rounds, a summary page will be shown. It shows how many questions are answered correctly and the details of each question.

![Geoguess Demo](demo/Geoguess_Demo.gif)

## Built With
* Google Maps SDK for iOS(https://developers.google.com/maps/documentation/ios-sdk/intro): utilize the Street View panoramas service to obtain the imagery for a city used in Google Maps Street View.
* [Charts library](https://github.com/danielgindi/Charts): to show the game statistics in the summary page. 
