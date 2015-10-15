unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, dblookup, Grids, DBGrids, FileCtrl;

type
  TForm1 = class(TForm)
    drvcbb1: TDriveComboBox;
    fltcbb1: TFilterComboBox;
    dirlst1: TDirectoryListBox;
    fllst1: TFileListBox;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    btn4: TButton;
    edt1: TEdit;
    dirlst2: TDirectoryListBox;
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   function DeleteDir(Dir: string): boolean;
implementation

{$R *.dfm}

function DeleteDir(Dir: string): boolean;
Var
 Found: integer;
 SearchRec: TSearchRec;
begin
 result:=false;
 if IOResult<>0 then;
 ChDir(Dir);
 if IOResult<>0 then begin
 ShowMessage('Не могу войти в каталог: '+Dir); exit;
 end;
 Found:= FindFirst('*.*', faAnyFile, SearchRec);
 while Found = 0 do begin
 if (SearchRec.Name<>'.')and(SearchRec.Name<>'..') then
 if (SearchRec.Attr and faDirectory)<>0 then begin
 if not DeleteDir(SearchRec.Name) then exit;
 end else
 if not DeleteFile(SearchRec.Name) then begin
 ShowMessage('Не могу удалить файл: '+SearchRec.Name); exit;
 end;
 Found:= FindNext(SearchRec);
 end;
 FindClose(SearchRec);
 ChDir('..'); RmDir(Dir);
 result:=IOResult=0;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
DeleteFile(PChar(fllst1.FileName));
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
 CopyFile(PChar(fllst1.FileName),PChar(dirlst1.Directory+'\'+edt1.Text), false);
end;

procedure TForm1.btn3Click(Sender: TObject);
begin
CreateDir(PChar(dirlst1.Directory + '\' + edt1.Text));
end;

procedure TForm1.btn4Click(Sender: TObject);
begin
 DeleteDir(PChar(dirlst1.Directory + '\' ));

end;




end.
