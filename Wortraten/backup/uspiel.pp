unit uspiel;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

	{ TSpiel }

  TSpiel = class(TObject)
    public
      constructor Create;
      destructor Destroy; reintroduce;
      procedure setzeSpielereingabe(sEingabe : string);
      procedure StarteSpiel;
      function sGibVerschluesselung : string;
      function bGeraten : Boolean;
      function sGibHinweis : string;
      function sGibVersuche : string;
      function iGibNichtErratene : Integer;
    private
      sWort, sSpielereingabe, sVerschluesselung, sHinweis : string;
      iVersuche, iNichtErratene : Integer;
      bErraten : Boolean;
      procedure Auswerten;
  end;

implementation

{ TSpiel }

const
  asWortliste: array[0..9] of string = ('Haus', 'Baum', 'Strasse', 'Auto', 'Apfel', 'Banane', 'Kekse', 'Analphabet', 'Pascal', 'Abrakadabra');

var
  iNr: Integer;

constructor TSpiel.Create;
begin
  inherited Create;
  Randomize;
end;

destructor TSpiel.Destroy;
begin
  inherited Destroy;
end;

procedure TSpiel.setzeSpielereingabe(sEingabe : string);
begin
  sSpielereingabe := AnsiLowerCase(sEingabe);
  Auswerten;
end;

procedure TSpiel.StarteSpiel;
begin
  iVersuche := 0;
  iNichtErratene := Length(sWort);
  sHinweis := '';
  bErraten := False;
  sWort := asWortliste[random(3)];
  sVerschluesselung := StringOfChar('*', Length(sWort));
end;

function TSpiel.sGibVerschluesselung : string;
begin
  Result := sVerschluesselung;
end;

function TSpiel.bGeraten : Boolean;
begin
  Result := bErraten;
end;

function TSpiel.sGibHinweis : string;
begin
  Result := sHinweis;
end;

function TSpiel.sGibVersuche : string;
begin
  Result := IntToStr(iVersuche);
end;

function TSpiel.iGibNichtErratene : Integer;
begin
  Result := iNichtErratene;
end;

procedure TSpiel.Auswerten;
begin
  sHinweis := 'Du hast keinen Buchstaben erraten!';
  for iNr := 1 to Length(sWort) do
	begin
    if (AnsiLowerCase(sWort[iNr]) = sSpielereingabe[1]) then
    begin
	    sVerschluesselung[iNr] := sWort[iNr];
	    iNichtErratene := iNichtErratene - 1;
	    sHinweis := 'Noch ' + IntToStr(iNichtErratene) + ' Buchstabe(n) sind zu erraten!';
      if sVerschluesselung = sWort then
      begin
        bErraten := True;
        sHinweis := 'Du hast das Wort erraten!';
			end;
		end;
	end;

	if AnsiLowerCase(sWort) = sSpielereingabe then
  begin
    sVerschluesselung := sWort;
    bErraten := True;
    sHinweis := 'Du hast das Wort erraten!';
  end;

  Inc(iVersuche);
end;

end.

