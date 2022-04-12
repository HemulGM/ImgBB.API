program ImgBB.Sample;

uses
  System.SysUtils,
  ImgBB.API in '..\ImgBB.API.pas';

var
  Token: string = {$INCLUDE token.key}; // get key api https://api.imgbb.com/

begin
  ReportMemoryLeaksOnShutdown := True;
  var ImgBB: IImgBB := TImgBB.Create(Token);
  var ImgUrl: string;
  if ImgBB.Upload('..\..\sample.png', ImgUrl, nil, 'sample', 1000) then
    Writeln(ImgUrl)
  else
    Writeln('Error');
  readln;
end.
