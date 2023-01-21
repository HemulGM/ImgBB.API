unit ImgBB.API;

interface

uses
  System.Classes, System.SysUtils, System.Net.HttpClient, System.Net.URLClient,
  System.Net.Mime;

type
  EImgBBWrapper = class(Exception);

  {$IF CompilerVersion < 34.0}
  TSendDataCallback = reference to procedure(const Sender: TObject; AContentLength: Int64; AWriteCount: Int64; var AAbort: Boolean);
  {$ENDIF}

  TImgBBUploadResponse = class
  private
    type

      TImgBBError = class
      private
        FCode: Integer;
        FMessage: string;
      public
        property Code: Integer read FCode write FCode;
        property Message: string read FMessage write FMessage;
      end;


      TImgBBLink = class
      private
        FExtension: string;
        FFilename: string;
        FMime: string;
        FName: string;
        FUrl: string;
      public
        property Extension: string read FExtension write FExtension;
        property Filename: string read FFilename write FFilename;
        property Mime: string read FMime write FMime;
        property Name: string read FName write FName;
        property Url: string read FUrl write FUrl;
      end;


      TImgBBData = class
      private
        FDelete_url: string;
        FDisplay_url: string;
        FExpiration: Int64;
        FId: string;
        FImage: TImgBBLink;
        FMedium: TImgBBLink;
        FSize: Int64;
        FThumb: TImgBBLink;
        FTime: Int64;
        FTitle: string;
        FUrl: string;
        FUrl_viewer: string;
      public
        property DeleteUrl: string read FDelete_url write FDelete_url;
        property DisplayUrl: string read FDisplay_url write FDisplay_url;
        property Expiration: Int64 read FExpiration write FExpiration;
        property Id: string read FId write FId;
        property Image: TImgBBLink read FImage;
        property Medium: TImgBBLink read FMedium;
        property Size: Int64 read FSize write FSize;
        property Thumb: TImgBBLink read FThumb;
        property Time: Int64 read FTime write FTime;
        property Title: string read FTitle write FTitle;
        property Url: string read FUrl write FUrl;
        property UrlViewer: string read FUrl_viewer write FUrl_viewer;
        destructor Destroy; override;
      end;
  private
    FData: TImgBBData;
    FStatus: Integer;
    FSuccess: Boolean;
    FError: TImgBBError;
    FStatusCode: Integer;
    FStatusTxt: string;
  public
    property Data: TImgBBData read FData;
    property Status: Integer read FStatus write FStatus;
    property Success: Boolean read FSuccess write FSuccess;
    //
    property Error: TImgBBError read FError;
    property StatusCode: Integer read FStatusCode write FStatusCode;
    property StatusTxt: string read FStatusTxt write FStatusTxt;
    destructor Destroy; override;
  end;

  IImgBB = interface
    ['{1C9FA631-5F45-4853-88CA-47525DB9E57C}']
    /// <summary>
    /// Image Upload from file
    /// </summary>
    function Upload(const FileName: string; CallBack: TSendDataCallback = nil; const Name: string = ''; Expiration: Integer = 60): TImgBBUploadResponse; overload;
    /// <summary>
    /// Image Upload from file
    /// </summary>
    function UploadGetUrl(const FileName: string; CallBack: TSendDataCallback = nil; const Name: string = ''; Expiration: Integer = 60): string; overload;
    /// <summary>
    /// Image Upload from stream
    /// </summary>
    function Upload(const Stream: TStream; const FileName: string; CallBack: TSendDataCallback = nil; const Name: string = ''; Expiration: Integer = 60): TImgBBUploadResponse; overload;
    /// <summary>
    /// Image Upload from stream
    /// </summary>
    function UploadGetUrl(const Stream: TStream; const FileName: string; CallBack: TSendDataCallback = nil; const Name: string = ''; Expiration: Integer = 60): string; overload;
    /// <summary>
    /// Image Upload from url
    /// </summary>
    function Upload(const URI: TURI; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): TImgBBUploadResponse; overload;
    /// <summary>
    /// Image Upload from url
    /// </summary>
    function UploadGetUrl(const URI: TURI; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): string; overload;
    /// <summary>
    /// Image Upload from base64
    /// </summary>
    function Upload(const Base64: TStringList; const FileName: string; CallBack: TSendDataCallback = nil; const Name: string = ''; Expiration: Integer = 60): TImgBBUploadResponse; overload;
    /// <summary>
    /// Image Upload from base64
    /// </summary>
    function UploadGetUrl(const Base64: TStringList; const FileName: string; CallBack: TSendDataCallback = nil; const Name: string = ''; Expiration: Integer = 60): string; overload;
  end;

  TImgBB = class(TInterfacedObject, IImgBB)
    const
      UrlUpload = 'https://api.imgbb.com/1/upload';
  private
    FKey: string;
    FAPIUrl: string;
    function Upload(Body: TMultipartFormData; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): TImgBBUploadResponse; overload;
  public
    /// <summary>
    /// Image Upload from file
    /// </summary>
    function Upload(const FileName: string; CallBack: TSendDataCallback = nil; const Name: string = ''; Expiration: Integer = 60): TImgBBUploadResponse; overload;
    /// <summary>
    /// Image Upload from file
    /// </summary>
    function UploadGetUrl(const FileName: string; CallBack: TSendDataCallback = nil; const Name: string = ''; Expiration: Integer = 60): string; overload;
    /// <summary>
    /// Image Upload from stream
    /// </summary>
    function Upload(const Stream: TStream; const FileName: string; CallBack: TSendDataCallback = nil; const Name: string = ''; Expiration: Integer = 60): TImgBBUploadResponse; overload;
    /// <summary>
    /// Image Upload from stream
    /// </summary>
    function UploadGetUrl(const Stream: TStream; const FileName: string; CallBack: TSendDataCallback = nil; const Name: string = ''; Expiration: Integer = 60): string; overload;
    /// <summary>
    /// Image Upload from url
    /// </summary>
    function Upload(const URI: TURI; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): TImgBBUploadResponse; overload;
    /// <summary>
    /// Image Upload from url
    /// </summary>
    function UploadGetUrl(const URI: TURI; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): string; overload;
    /// <summary>
    /// Image Upload from base64
    /// </summary>
    function Upload(const Base64: TStringList; const FileName: string; CallBack: TSendDataCallback = nil; const Name: string = ''; Expiration: Integer = 60): TImgBBUploadResponse; overload;
    /// <summary>
    /// Image Upload from base64
    /// </summary>
    function UploadGetUrl(const Base64: TStringList; const FileName: string; CallBack: TSendDataCallback = nil; const Name: string = ''; Expiration: Integer = 60): string; overload;
    /// <summary>
    /// The API key
    /// </summary>
    property Key: string read FKey write FKey;
    /// <summary>
    /// Create API
    /// </summary>
    /// <param name="AKey: string">The API key. Get key api from api.imgbb.com</param>
    /// <param name="AAPIUrl: string">API url - default UrlUpload const</param>
    constructor Create(const AKey: string; const AAPIUrl: string = UrlUpload);
    class function Instance(const AKey: string; const AAPIUrl: string = UrlUpload): IImgBB;
  end;

function ImgBBAPI(const AKey: string; const AAPIUrl: string = TImgBB.UrlUpload): IImgBB;

implementation

uses
  REST.Json;

function ImgBBAPI(const AKey: string; const AAPIUrl: string): IImgBB;
begin
  Result := TImgBB.Instance(AKey, AAPIUrl);
end;

{ TImgBB }

constructor TImgBB.Create(const AKey: string; const AAPIUrl: string);
begin
  inherited Create;
  FKey := AKey;
  FAPIUrl := AAPIUrl;
end;

function TImgBB.Upload(Body: TMultipartFormData; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): TImgBBUploadResponse;
var
  URI: TURI;
  Client: THTTPClient;
  ResponseStream: TStringStream;
  Success: Boolean;
begin
  Client := THTTPClient.Create;
  ResponseStream := TStringStream.Create;
  try
    {$IF CompilerVersion >= 34.0}
    Client.SendDataCallback := CallBack;
    {$ENDIF}
    // Uri construct
    URI := TURI.Create(UrlUpload);
    // Params
    URI.AddParameter('key', FKey);
    if not Name.IsEmpty then
      URI.AddParameter('name', Name);
    if Expiration > 60 then
      URI.AddParameter('expiration', Expiration.ToString);
    // Execute
    Success := Client.Post(URI.ToString, Body, ResponseStream).StatusCode = 200;
    // Parse
    if ResponseStream.Size > 0 then
    begin
      ResponseStream.Position := 0;
      Result := TJson.JsonToObject<TImgBBUploadResponse>(ResponseStream.DataString);
      if not Assigned(Result) then
        raise EImgBBWrapper.Create('Json is empty');
      if not Success then
      try
        if Assigned(Result.Error) then
          raise EImgBBWrapper.Create('ImgBB error: ' + Result.Error.Message + ' (' + Result.Error.Code.ToString + ')')
        else
          raise EImgBBWrapper.Create('Unknown error');
      finally
        Result.Free;
      end;
    end
    else
      raise EImgBBWrapper.Create('Response is empty');
  finally
    ResponseStream.Free;
    Client.Free;
  end;
end;

function TImgBB.Upload(const Stream: TStream; const FileName: string; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): TImgBBUploadResponse;
var
  Body: TMultipartFormData;
begin
  Body := TMultipartFormData.Create;
  try
    // Body - file
    Body.AddStream('image', Stream, FileName);
    Result := Upload(Body, CallBack, Name, Expiration);
  finally
    Body.Free;
  end;
end;

function TImgBB.UploadGetUrl(const URI: TURI; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): string;
var
  Response: TImgBBUploadResponse;
begin
  Response := Upload(URI, CallBack, Name, Expiration);
  try
    if Assigned(Response.Data) then
      Result := Response.Data.Url;
  finally
    Response.Free;
  end;
end;

function TImgBB.Upload(const URI: TURI; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): TImgBBUploadResponse;
var
  Body: TMultipartFormData;
begin
  Body := TMultipartFormData.Create;
  try
    // Body - uri
    Body.AddField('image', URI.ToString);
    Result := Upload(Body, CallBack, Name, Expiration);
  finally
    Body.Free;
  end;
end;

function TImgBB.UploadGetUrl(const Base64: TStringList; const FileName: string; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): string;
var
  Response: TImgBBUploadResponse;
begin
  Response := Upload(Base64, FileName, CallBack, Name, Expiration);
  try
    if Assigned(Response.Data) then
      Result := Response.Data.Url;
  finally
    Response.Free;
  end;
end;

class function TImgBB.Instance(const AKey: string; const AAPIUrl: string = UrlUpload): IImgBB;
begin
  Result := TImgBB.Create(AKey, AAPIUrl);
end;

function TImgBB.Upload(const Base64: TStringList; const FileName: string; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): TImgBBUploadResponse;
var
  Body: TMultipartFormData;
begin
  Body := TMultipartFormData.Create;
  try
    // Body - base64
    Body.AddField('image', Base64.Text);
    Result := Upload(Body, CallBack, Name, Expiration);
  finally
    Body.Free;
  end;
end;

function TImgBB.Upload(const FileName: string; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): TImgBBUploadResponse;
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmShareDenyWrite);
  try
    Result := Upload(FileStream, FileName, CallBack, Name, Expiration);
  finally
    FileStream.Free;
  end;
end;

function TImgBB.UploadGetUrl(const Stream: TStream; const FileName: string; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): string;
var
  Response: TImgBBUploadResponse;
begin
  Response := Upload(Stream, FileName, CallBack, Name, Expiration);
  try
    if Assigned(Response.Data) then
      Result := Response.Data.Url;
  finally
    Response.Free;
  end;
end;

function TImgBB.UploadGetUrl(const FileName: string; CallBack: TSendDataCallback; const Name: string; Expiration: Integer): string;
var
  Response: TImgBBUploadResponse;
begin
  Response := Upload(FileName, CallBack, Name, Expiration);
  try
    if Assigned(Response.Data) then
      Result := Response.Data.Url;
  finally
    Response.Free;
  end;
end;

{ TImgBBData }

destructor TImgBBUploadResponse.TImgBBData.Destroy;
begin
  if Assigned(FImage) then
    FImage.Free;
  if Assigned(FMedium) then
    FMedium.Free;
  if Assigned(FThumb) then
    FThumb.Free;
  inherited;
end;

{ TImgBBUploadResponse }

destructor TImgBBUploadResponse.Destroy;
begin
  if Assigned(FData) then
    FData.Free;
  if Assigned(FError) then
    FError.Free;
  inherited;
end;

end.

