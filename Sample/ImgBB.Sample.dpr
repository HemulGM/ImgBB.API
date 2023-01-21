program ImgBB.Sample;

uses
  System.SysUtils,
  ImgBB.API in '..\ImgBB.API.pas';

var
  Token: string = {$INCLUDE token.key}; // get key api https://api.imgbb.com/

begin
  ReportMemoryLeaksOnShutdown := True;
  try
    Writeln(ImgBBAPI(Token).UploadGetUrl('..\..\sample.png', nil, 'sample', 1000));
  except
    Writeln('Error');
  end;
  readln;
end.
