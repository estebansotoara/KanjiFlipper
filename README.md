# Welcome to KanjiFlipper!

An SRS iOS app for Kanji review. Long time resident of the bucket list and finally started as part of [Code With Friends Fall 2020](https://codewithfriends.io).

# Features

The app uses the entries of Remembering the Kanji I book so existing book users can take advantage of the character progression and keywords, the mnemonic stories however are left blank for the user to create.

The spaced repetition engine is based on the [SuperMemo](https://www.supermemo.com/en/archives1990-2015/english/algsm11) algorithm.

## Review

The review section lets you evaluate the due cards that you currently have added to the deck. 

## Study

The study section shows all the characters and a details view for each one, from here is possible to add a mnemonic story and add a card to the deck.

## Settings

The settings section shows options to reset the app data and tweak the SRS engine parameters.

# Tech

- Swift 5
- Core Data
- Combine

# TODO

The project is still on its barebones and there is lots of work to be done, among the required tasks to get to a MVP are:

- Add mnemonic story to card
- Add/remove cards to/from the deck
- Add SRS engine
- Add review session module
- Add support for cloud kit
- Have an actual design (iPhone and iPad)
