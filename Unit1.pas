unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    SaveDialog1: TSaveDialog;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
  uses FMX.Surfaces; // for tBitmapSurface;
{$R *.fmx}

procedure CreateLogo(bitmap: TBitmap; width, height: Integer);
var
  ColWidth: Integer;
  Colors: Array[0..5] of TAlphaColor;
begin
  bitmap.SetSize(width, height);  // Set the bitmap size
  bitmap.Clear(TAlphaColors.White);  // Optional: clear with white background

  // Define the colors based on HTML color codes
Colors[0] := TAlphaColor($FFA24C57); // Red
Colors[1] := TAlphaColor($FF685B87); // Purple
Colors[2] := TAlphaColor($FF4AA77A); // Green
Colors[3] := TAlphaColor($FFEBD524); // Yellow
Colors[4] := TAlphaColor($FFE77A3D); // Orange
Colors[5] := TAlphaColor($FFB11F38); // Dark Red

  // Calculate column width
  ColWidth := width div Length(Colors);

  // Draw each colored rectangle
  for var i := 0 to High(Colors) do
  begin
    bitmap.Canvas.BeginScene;
    bitmap.Canvas.Fill.Kind := TBrushKind.Solid;
    bitmap.Canvas.Fill.Color := Colors[i];
    bitmap.Canvas.FillRect(RectF(i * ColWidth, 0, (i + 1) * ColWidth, height), 0, 0, [], 1);
    bitmap.Canvas.EndScene;
  end;
end;
procedure TForm1.Button1Click(Sender: TObject);
begin
createLogo(Image1.Bitmap, StrToInt(Form1.Edit1.Text), StrToInt(Form1.Edit1.Text));
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  SaveDialog: TSaveDialog;
  Surface: TBitmapSurface;
  Params: TBitmapCodecSaveParams;
begin
    SaveDialog := TSaveDialog.Create(nil);
  try
    SaveDialog.Title := 'Save Image As';
    SaveDialog.Filter := 'PNG Image|*.png|JPEG Image|*.jpg';
    SaveDialog.DefaultExt := 'png';
    SaveDialog.FilterIndex := 1;
    if SaveDialog.Execute then
    begin



      Surface := TBitmapSurface.Create;
      try
        Surface.Assign(Image1.Bitmap);
        if SaveDialog.FilterIndex = 1 then
        begin
          TBitmapCodecManager.SaveToFile(SaveDialog.FileName, Surface);
        end
        else if SaveDialog.FilterIndex = 2 then
        begin
          Params.Quality := 90;  // Set JPEG quality from 1 to 100
          TBitmapCodecManager.SaveToFile(SaveDialog.FileName, Surface, @Params);
        end;
      finally
        Surface.Free;
      end;
    end;
  finally
    SaveDialog.Free;
  end;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  Image1.Width := Form1.ClientHeight - 2*(ClientHeight / 10);
  Image1.Height := Image1.Width;
  Image1.Position.X := 5;
  Image1.Position.Y := 5;

  Edit1.Position.X := 5;
  Edit1.Position.Y := Form1.ClientHeight - ClientHeight / 10;
  Edit1.Text := IntToStr(1024);

  Button1.Text := 'generate';
  Button1.Position.Y := Edit1.Position.Y;
  Button2.Position.Y := Edit1.Position.Y;
  Button2.Text := 'save';

end;

end.
