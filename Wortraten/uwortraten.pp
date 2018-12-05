unit uwortraten;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, uspiel;

type

	{ TFWortraten }

  TFWortraten = class(TForm)
		BRaten : TButton;
		BNeuesSpiel : TButton;
		EVersuche : TEdit;
		EWort : TEdit;
		EEingabe : TEdit;
		EHinweis : TEdit;
		LVersuche : TLabel;
 procedure BNeuesSpielClick(Sender : TObject);
 procedure BRatenClick(Sender : TObject);
  procedure FormCreate(Sender : TObject);
	procedure FormDestroy(Sender : TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FWortraten : TFWortraten;
  oSpiel : TSpiel;
implementation

{$R *.lfm}

{ TFWortraten }

procedure TFWortraten.FormCreate(Sender : TObject);
begin
  oSpiel := TSpiel.Create;
  oSpiel.StarteSpiel;
  EWort.Text := oSpiel.sGibVerschluesselung;
  EVersuche.Enabled := False;
  EHinweis.Enabled := False;
end;

procedure TFWortraten.BRatenClick(Sender : TObject);
begin
  if not(EEingabe.Text = '') then
  begin
	  oSpiel.setzeSpielereingabe(EEingabe.Text);
	  EWort.Text := oSpiel.sGibVerschluesselung;
	  if (oSpiel.bGeraten) then
	    begin
        EHinweis.Color := clGreen;
	      EHinweis.Text := oSpiel.sGibHinweis;
	      EEingabe.Enabled := False;
	      BRaten.Enabled := False;
			end;
	  EVersuche.Text := oSpiel.sGibVersuche;
	  EHinweis.Text := oSpiel.sGibHinweis;
	end
  else
    EHinweis.Text := 'Bitte Buchstaben eingeben';
end;

procedure TFWortraten.BNeuesSpielClick(Sender : TObject);
begin
  EHinweis.Text := '';
  EEingabe.Text := '';
  EVersuche.Text := '0';
  EHinweis.Color := clDefault;
  oSpiel.StarteSpiel;
  EWort.Text := oSpiel.sGibVerschluesselung;
  EEingabe.Enabled := True;
  BRaten.Enabled := True;
end;

procedure TFWortraten.FormDestroy(Sender : TObject);
begin
  oSpiel.Destroy;
  oSpiel := nil;
  oSpiel.Free;
end;

end.

