# ImgBB.API
 ImgBB API Wrapper


```Pascal
function Upload(const FileName: string; out Response: TImgBBUploadResponse): Boolean; overload;
function Upload(const Stream: TStream; const FileName: string; out Response: TImgBBUploadResponse): Boolean; overload;
function Upload(const FileName: string; out ImageUrl: string): Boolean; overload;
function Upload(const Stream: TStream; const FileName: string; out ImageUrl: string): Boolean; overload;
```

# Image url only
```Pascal
  ImgBB := TImgBB.Create(Token);
  try
    var ImgUrl: string;
    if ImgBB.Upload(EditFileName.Text, ImgUrl) then
      Memo1.Lines.Add(ImgUrl)
    else
      Memo1.Lines.Add('error');
  finally
    ImgBB.Free;
  end;
```

# Full response
```Pascal
  ImgBB := TImgBB.Create(Token);
  try
    var Response: TImgBBUploadResponse;
    if ImgBB.Upload(EditFileName.Text, Response) then
    begin
      if Assigned(Response) then
      try
        Memo1.Lines.Add(Response.Data.Url)
      finally
        Response.Free;
      end;
    end
    else
    begin
      if Assigned(Response) then
      try
        Memo1.Lines.Add(Response.Error.Message)
      finally
        Response.Free;
      end
      else
        Memo1.Lines.Add('error');
    end;
  finally
    ImgBB.Free;
  end;
```
