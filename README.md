Poker Game with Hand Evaluation


This project is a poker game implementation in Delphi, focusing on hand evaluation and scoring. The core functionality includes card deck management, hand evaluation (including Poker hand ranking like Royal Flush, Full House, etc.), and the logic for determining which player (or bot) wins based on the strength of their hand. This game also supports community cards and player actions such as betting and dealing cards.

Features
Card Types: Defines card suits (Hearts, Diamonds, Clubs, Spades) and ranks (2 through Ace).

Deck Management: Functions to initialize, shuffle, and deal cards.

Hand Evaluation: A Poker hand evaluator that ranks hands based on standard Poker rules:

High Card

One Pair

Two Pair

Three of a Kind

Straight

Flush

Full House

Four of a Kind

Straight Flush

Royal Flush

Community Cards: Allows for community cards in a Texas Hold'em style game.

Bot Logic: Evaluates the bot's hand and determines if it wins against the player.

User Interface: Basic UI components to display cards and results of hand evaluations.

Technologies Used
Delphi: The main language used for developing the poker game.

Card Handling: Custom data types and records for representing cards and decks.

Card Evaluation Logic: Implements the logic to evaluate Poker hands and determine the best hand at the showdown.


How to Play
The game follows Texas Hold'em rules. At the start, the game will deal two hole cards to each player and a set of community cards. Players will have the chance to place bets and make decisions based on the cards they are dealt.

Dealing Cards: The game will automatically deal two cards to each player, followed by three community cards.

Hand Evaluation: Once the community cards are dealt, the poker hands are evaluated, and the player with the highest-ranking hand wins the round.

Winning Criteria: The hand evaluator compares hands using the following ranking:

1: High Card

2: One Pair

3: Two Pair

4: Three of a Kind

5: Straight

6: Flush

7: Full House

8: Four of a Kind

9: Straight Flush

10: Royal Flush

Code Structure
CardTypes.pas: Defines the card suits, ranks, and the deck structure. Also includes functions for initializing and shuffling the deck.

PokerHandEvaluator.pas: Contains the logic to evaluate the strength of a hand based on the cards dealt to the player and the community cards.
