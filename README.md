# Facebook Search

Chrome Extension for easy filtering filtering of Facebook grups posts.

## Installation

Install extension from [Chrome Store](https://chrome.google.com/webstore/detail/facebook-search/acablmnboplljgpnncnmdnndjofkldmk) or build it from this repository.

## Building

Firstly install all necessary dependencies.
```
brew install graphicsmagick # For icon resizing
npm install
npm install -g grunt-cli
```

Then there are several tasks.
```
grunt build   # build extensions along sourcemaps
grunt release # build zip (for chrome) archives of extensions
grunt watch   # continously build extensions
```
