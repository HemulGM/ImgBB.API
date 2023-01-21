# ImgBB.API

Загрузка картинок на хостинг https://imgbb.com/

Получить токен: https://api.imgbb.com/

 ImgBB API Wrapper


```Pascal
function Upload(FileName, CallBack, Name, Expiration): TImgBBUploadResponse;
function Upload(Stream, FileName, CallBack, Name, Expiration): TImgBBUploadResponse;
function Upload(URI, CallBack, Name, Expiration): TImgBBUploadResponse;
function Upload(Base64, FileName, CallBack, Name, Expiration): TImgBBUploadResponse;

function UploadGetUrl(FileName, CallBack, Name, Expiration): string;
function UploadGetUrl(Stream, FileName, CallBack, Name; Expiration): string;
function UploadGetUrl(URI, CallBack, Name, Expiration): string;
function UploadGetUrl(Base64, FileName, CallBack, Name; Expiration): string;
```

# Get image url only from file and single call
```Pascal
Memo1.Lines.Add(ImgBBAPI(Token).Upload(EditFileName.Text));
```

# Get full response from base64 image
```Pascal
var ImgBB := TImgBB.Instance(Token);
var Response := ImgBB.Upload(Base64Strings) then
try
  Memo1.Lines.Add(Response.Data.Url);
finally
  Response.Free;
end;
```
