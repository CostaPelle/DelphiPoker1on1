unit CardTypes;

interface

type
  TCardSuit = (Hearts, Diamonds, Clubs, Spades);
  TCardRank = (Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace);

  TCard = record
    Suit: TCardSuit;
    Rank: TCardRank;
  end;

  TDeck = array of TCard;

procedure InitDeck(var Deck: TDeck);
procedure ShuffleDeck(var Deck: TDeck);

implementation

uses
  System.SysUtils;

procedure InitDeck(var Deck: TDeck);
var
  s: TCardSuit;
  r: TCardRank;
  Index: Integer;
begin
  SetLength(Deck, 52);
  Index := 0;
  for s := Low(TCardSuit) to High(TCardSuit) do
    for r := Low(TCardRank) to High(TCardRank) do
    begin
      Deck[Index].Suit := s;
      Deck[Index].Rank := r;
      Inc(Index);
    end;
end;

procedure ShuffleDeck(var Deck: TDeck);
var
  i, j: Integer;
  temp: TCard;
begin
  Randomize;
  for i := High(Deck) downto 1 do
  begin
    j := Random(i + 1);
    temp := Deck[i];
    Deck[i] := Deck[j];
    Deck[j] := temp;
  end;
end;

end.

