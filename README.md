# ImgBB.API

Загрузка картинок на хостинг https://imgbb.com/

Получить токен: https://api.imgbb.com/

 ImgBB API Wrapper


```Pascal
function Upload(const URI: TURI; out Response: TImgBBUploadResponse; CallBack: TSendDataEvent = nil; const Name: string = ''; Expiration: Integer = 60): Boolean; overload;
function Upload(const URI: TURI; out ImageUrl: string; CallBack: TSendDataEvent = nil; const Name: string = ''; Expiration: Integer = 60): Boolean; overload;
function Upload(const FileName: string; out Response: TImgBBUploadResponse; CallBack: TSendDataEvent = nil; const Name: string = ''; Expiration: Integer = 60): Boolean; overload;
function Upload(const FileName: string; out ImageUrl: string; CallBack: TSendDataEvent = nil; const Name: string = ''; Expiration: Integer = 60): Boolean; overload;
function Upload(const Stream: TStream; const FileName: string; out Response: TImgBBUploadResponse; CallBack: TSendDataEvent = nil; const Name: string = ''; Expiration: Integer = 60): Boolean; overload;
function Upload(const Stream: TStream; const FileName: string; out ImageUrl: string; CallBack: TSendDataEvent = nil; const Name: string = ''; Expiration: Integer = 60): Boolean; overload;
function Upload(const Base64: TStringList; const FileName: string; out Response: TImgBBUploadResponse; CallBack: TSendDataEvent = nil; const Name: string = ''; Expiration: Integer = 60): Boolean; overload;
function Upload(const Base64: TStringList; const FileName: string; out ImageUrl: string; CallBack: TSendDataEvent = nil; const Name: string = ''; Expiration: Integer = 60): Boolean; overload;
```

# Image url only
```Pascal
  ImgBB: IImgBB := TImgBB.Create(Token);
  var ImgUrl: string;
  if ImgBB.Upload(EditFileName.Text, ImgUrl) then
    Memo1.Lines.Add(ImgUrl);
```

# Full response
```Pascal
  ImgBB: IImgBB := TImgBB.Create(Token);
  var Response: TImgBBUploadResponse;
  if ImgBB.Upload(EditFileName.Text, Response) then
  try
    Memo1.Lines.Add(Response.Data.Url)
  finally
    Response.Free;
  end;
```
