# ImgBB.API
 ImgBB API Wrapper


# Image url only
```Pascal
  ImgBB := TImgBB.Create(Token);
  try
    var ImgUrl: string;
    if ImgBB.Upload(Edit1.Text, ImgUrl) then
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
    if ImgBB.Upload(Edit1.Text, Response) then
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
