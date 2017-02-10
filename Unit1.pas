unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, ComCtrls, Buttons, ScktComp,
  WinSkinData, Menus, WinSkinStore;

type
  TForm1 = class(TForm)
    img1: TImage;
    lbl1: TLabel;
    edt1: TEdit;
    lbl2: TLabel;
    edt2: TEdit;
    lbl3: TLabel;
    edt3: TEdit;
    lbl4: TLabel;
    edt4: TEdit;
    lbl5: TLabel;
    pb1: TProgressBar;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    tmr1: TTimer;
    clntsckt1: TClientSocket;
    lbl6: TLabel;
    lbl7: TLabel;
    lst1: TListBox;
    skndt1: TSkinData;
    sknstr1: TSkinStore;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    procedure pnl2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure pnl1Click(Sender: TObject);
    procedure clntsckt1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure clntsckt1Connect(Sender: TObject; Socket: TCustomWinSocket);
   
    procedure clntsckt1Disconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure pnl3Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N2Click(Sender: TObject);



   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
var
  d:Integer = 0;


procedure TForm1.pnl2Click(Sender: TObject);
begin
   if Trim(edt1.Text) = '' then
   ShowMessage('������Ҫɨ���IP')
   else
   if Trim(edt2.Text) = '' then
   ShowMessage('������˿�ʼ��Χ��')
   
   else
   if Trim(edt3.Text) = '' then
   ShowMessage('������˿�ĩ��Χ��')

   else
   if Trim(edt4.Text) = '' then
   ShowMessage('������˿�ɨ�����ʣ�');//������

   edt1.Enabled:=False;
   edt2.Enabled:=False;
   edt3.Enabled:=False;
   edt4.Enabled:=False;           //ɨ������в����Զ�edit������޸�
  if pnl2.Caption = 'ɨ��' then
  begin
   pnl2.Caption:='ֹͣ';
   pnl2.Color:= clRed;
   pnl3.Visible:=True;   //�ı���������ɫ
   lst1.Visible:=True;

   lst1.Items.Clear;      //����Ա��ٴ�ʹ��ɨ��

   pb1.Min:=0;
   pb1.Max:=StrToInt(edt3.Text)-StrToInt(edt2.Text); //���ý���

   tmr1.Enabled:=True;
   tmr1.Interval:=StrToInt(edt4.Text);
    end
    else if pnl2.Caption = 'ֹͣ' then
    begin
      edt1.Enabled:=True;
      edt2.Enabled:=True;
      edt3.Enabled:=True;
      edt4.Enabled:=True;    //���Զ�edit�����޸���

      d:=0;    //��ʼ���˿�

      pnl3.Visible:=False;

      tmr1.Enabled:=False;
      pb1.Step:=0;

      pnl2.Caption:='ɨ��';
      pnl2.Color:=clBlue;
    end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    tmr1.Enabled:=False;
    pnl3.Visible:=False;
    lst1.Visible:=False;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
begin
   if clntsckt1.Port < StrToInt(edt3.Text) then
   begin
     clntsckt1.Port:=d;
     clntsckt1.Address:=edt1.Text;
     clntsckt1.Open;
     lbl7.Caption:=IntToStr(d);
     d:=d+1;
     pb1.StepBy(1);
   end
   else if clntsckt1.Port >= StrToInt(edt3.Text) then
   begin
     edt1.Enabled:=True;
     edt2.Enabled:=True;
     edt3.Enabled:=True;
     edt4.Enabled:=True;

     pnl3.Visible:=False;
     pnl2.Caption:='ɨ��';
     pnl2.Color:=clBlue;

     tmr1.Enabled:=False;
   end;
end;

procedure TForm1.pnl1Click(Sender: TObject);
begin
   Close;
end;

procedure TForm1.clntsckt1Error(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
   ErrorCode:=0;
end;

procedure TForm1.clntsckt1Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
    lst1.Items.Add('Port:'+IntTOStr(clntsckt1.Port)) ;
    clntsckt1.Close;

    if clntsckt1.Port = StrToInt(edt3.Text) then
    tmr1.Enabled:=False;
end;



procedure TForm1.clntsckt1Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
     tmr1.Enabled:=True;
end;

procedure TForm1.pnl3Click(Sender: TObject);
begin
  if pnl3.Caption = '��ͣɨ��' then
  begin
   pnl3.Caption:='�ָ�ɨ��';
   tmr1.Enabled:=False;
   end
   else if pnl3.Caption = '�ָ�ɨ��' then
   begin
     pnl3.Caption:='��ͣɨ��';
     tmr1.Enabled:=True;
   end;
end;



procedure TForm1.N11Click(Sender: TObject);
begin
   skndt1.LoadFromCollection(sknstr1,0);
end;

procedure TForm1.N21Click(Sender: TObject);
begin
      skndt1.LoadFromCollection(sknstr1,1);
end;

procedure TForm1.N31Click(Sender: TObject);
begin
      skndt1.LoadFromCollection(sknstr1,2);
end;

procedure TForm1.N2Click(Sender: TObject);
begin
    Close;
end;

end.

.
