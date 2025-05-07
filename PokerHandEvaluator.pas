unit PokerHandEvaluator;

interface

uses
  System.SysUtils, System.Generics.Collections, CardTypes, Math;

type
  TPokerHandEvaluator = class
  public
    function GetHandScore(Card1, Card2: TCard; Community: TArray<TCard>): Single;
  end;

implementation

function TPokerHandEvaluator.GetHandScore(Card1, Card2: TCard; Community: TArray<TCard>): Single;
var
  AllCards: TArray<TCard>;
  i: Integer;
  Values: TList<Integer>;
  Suits: TList<TCardSuit>;
  ValueCounts: TDictionary<Integer, Integer>;
  CountList: TList<Integer>;
  IsFlush, IsStraight, IsRoyal: Boolean;
  SortedValues: TArray<Integer>;
begin
  Result := 1; // Default to High Card

  // Combine all cards
  SetLength(AllCards, Length(Community) + 2);
  AllCards[0] := Card1;
  AllCards[1] := Card2;
  for i := 0 to High(Community) do
    AllCards[i + 2] := Community[i];

  Values := TList<Integer>.Create;
  Suits := TList<TCardSuit>.Create;
  ValueCounts := TDictionary<Integer, Integer>.Create;
  CountList := TList<Integer>.Create;

  try
    // Gather values and suits
    for i := 0 to High(AllCards) do
    begin
      Values.Add(AllCards[i].Value);
      Suits.Add(AllCards[i].Suit);

      if not ValueCounts.ContainsKey(AllCards[i].Value) then
        ValueCounts.Add(AllCards[i].Value, 1)
      else
        ValueCounts[AllCards[i].Value] := ValueCounts[AllCards[i].Value] + 1;
    end;

    // Sort values
    SortedValues := Values.ToArray;
    TArray.Sort<Integer>(SortedValues);

    // Check for flush
    IsFlush := True;
    for i := 1 to Suits.Count - 1 do
    begin
      if Suits[i] <> Suits[0] then
      begin
        IsFlush := False;
        Break;
      end;
    end;

    // Check for straight
    IsStraight := True;
    for i := 0 to Length(SortedValues) - 2 do
    begin
      if SortedValues[i + 1] <> SortedValues[i] + 1 then
      begin
        IsStraight := False;
        Break;
      end;
    end;

    // Ace-low straight (A 2 3 4 5)
    if not IsStraight and
       (SortedValues[0] = 2) and (SortedValues[1] = 3) and
       (SortedValues[2] = 4) and (SortedValues[3] = 5) and
       (SortedValues[High(SortedValues)] = 14) then
    begin
      IsStraight := True;
    end;

    IsRoyal := IsFlush and IsStraight and (SortedValues[0] = 10);

    // Count occurrences
    for var Val in ValueCounts.Values do
      CountList.Add(Val);
    CountList.Sort;

// Score evaluation
if IsRoyal then
  Result := 10
else if IsFlush and IsStraight then
  Result := 9
else if CountList.Last = 4 then
begin
  Result := 8;
  // Four of a Kind - add 0.01 × value
  for var V in ValueCounts.Keys do
    if ValueCounts[V] = 4 then
    begin
      Result := Result + V * 0.01;
      Break;
    end;
end
else if (CountList.Contains(3)) and (CountList.Contains(2)) then
begin
  Result := 7;
  var ThreeVal, PairVal: Integer;
  ThreeVal := 0;
  PairVal := 0;
  for var V in ValueCounts.Keys do
  begin
    if ValueCounts[V] = 3 then
      ThreeVal := V
    else if ValueCounts[V] = 2 then
      PairVal := V;
  end;
  Result := Result + (ThreeVal * 0.01) + (PairVal * 0.001);
end
else if IsFlush then
  Result := 6
else if IsStraight then
  Result := 5
else if CountList.Last = 3 then
begin
  Result := 4;
  // Three of a Kind - add 0.01 × value
  for var V in ValueCounts.Keys do
    if ValueCounts[V] = 3 then
    begin
      Result := Result + V * 0.01;
      Break;
    end;
end
else if CountList.Count = 4 then
begin
  Result := 2;
  // One Pair - add 0.01 × pair value
  var PairValue: Integer := -1;
  for var V in ValueCounts.Keys do
    if ValueCounts[V] = 2 then
    begin
      PairValue := V;
      Result := Result + V * 0.01;
      Break;
    end;
    // Add remaining kickers
  var Kickers: TList<Integer> := TList<Integer>.Create;
  try
    for var V in ValueCounts.Keys do
      if (ValueCounts[V] = 1) and (V <> PairValue) then
        Kickers.Add(V);

    Kickers.Sort;
    Kickers.Reverse; // Highest kicker first

    for I := 0 to Kickers.Count - 1 do
      Result := Result + Kickers[I] * Power(0.0001, I + 1); // e.g., 0.0001, 0.00001, ...
  finally
    Kickers.Free;
  end;
end
else if CountList.Last = 2 then
begin
  Result := 3;
  var Pairs: TList<Integer> := TList<Integer>.Create;
  var KickerValue: Integer := -1;
  try
    for var V in ValueCounts.Keys do
    begin
      if ValueCounts[V] = 2 then
        Pairs.Add(V)
      else if ValueCounts[V] = 1 then
        KickerValue := V;
    end;

    Pairs.Sort;
    if Pairs.Count > 0 then
      Result := Result + (Pairs.Last * 0.01);
    if Pairs.Count > 1 then
      Result := Result + (Pairs[Pairs.Count - 2] * 0.001);

    if KickerValue <> -1 then
      Result := Result + KickerValue * 0.0001;         // kicker card
  finally
    Pairs.Free;
  end;
end
else
begin
  Result := 1;
  // High card - add decreasing decimal weight for each card
  if Length(SortedValues) > 0 then
  begin
    var DecimalWeight := 0.001;
    for i := High(SortedValues) downto Low(SortedValues) do
    begin
      Result := Result + SortedValues[i] * DecimalWeight;
      DecimalWeight := DecimalWeight / 10; // Reduce weight for next lower card
    end;
  end;
end;



  finally
    Values.Free;
    Suits.Free;
    ValueCounts.Free;
    CountList.Free;
  end;
end;

end.
