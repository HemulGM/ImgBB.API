unit ImgBB.API;

interface

uses
  System.Classes, System.SysUtils;

type
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
    function Upload(const FileName: string; Name: string = ''; Expiration: Integer = 60): TImgBBUploadResponse; overload;
    function Upload(const Stream: TStream; const FileName: string; Name: string = ''; Expiration: Integer = 60): TImgBBUploadResponse; overload;
    function Upload(const FileName: string; Name: string = ''; Expiration: Integer = 60): string; overload;
    function Upload(const Stream: TStream; const FileName: string; Name: string = ''; Expiration: Integer = 60): string; overload;
  end;

  TImgBB = class(TInterfacedObject, IImgBB)
    const
      UrlUpload = 'https://api.imgbb.com/1/upload';
  private
    FKey: string;
    FAPIUrl: string;
  public
    /// <summary>
    /// Image Upload from file
    /// </summary>
    function Upload(const FileName: string; Name: string = ''; Expiration: Integer = 60): TImgBBUploadResponse; overload;
    /// <summary>
    /// Image Upload from file
    /// </summary>
    function Upload(const FileName: string; Name: string = ''; Expiration: Integer = 60): string; overload;
    /// <summary>
    /// Image Upload from stream
    /// </summary>
    function Upload(const Stream: TStream; const FileName: string; Name: string = ''; Expiration: Integer = 60): TImgBBUploadResponse; overload;
    /// <summary>
    /// Image Upload from stream
    /// </summary>
    function Upload(const Stream: TStream; const FileName: string; Name: string = ''; Expiration: Integer = 60): string; overload;
    /// <summary>
    /// The API key
    /// </summary>
    property Key: string read FKey write FKey;
    /// <param name="AKey: string">The API key. Get key api from https://api.imgbb.com</param>
    /// <param name="AAPIUrl: string">API url - default UrlUpload const</param>
    constructor Create(const AKey: string; const AAPIUrl: string = UrlUpload);
  end;

implementation

uses
  REST.Json, System.Net.HttpClient, System.Net.Mime, System.Net.URLClient;

{ TImgBB }

constructor TImgBB.Create(const AKey: string; const AAPIUrl: string);
begin
  inherited Create;
  FKey := AKey;
  FAPIUrl := AAPIUrl;
end;

function TImgBB.Upload(const Stream: TStream; const FileName: string; const Name: string; Expiration: Integer): TImgBBUploadResponse;
var
  Client: THTTPClient;
  Body: TMultipartFormData;
  ResponseStream: TStringStream;
begin
  Response := nil;
  Client := THTTPClient.Create;
  Body := TMultipartFormData.Create;
  ResponseStream := TStringStream.Create;
  try
    // Body - file
    Body.AddStream('image', Stream, FileName);
    // Uri construct
    var Uri := TURI.Create(UrlUpload);
    Uri.AddParameter('key', FKey);
    if not Name.IsEmpty then
      Uri.AddParameter('name', Name);
    if Expiration > 60 then
      Uri.AddParameter('expiration', Expiration.ToString);
    // Execute
    Result := Client.Post(Uri.ToString, Body, ResponseStream).StatusCode = 200;
    // Parse
    if ResponseStream.Size > 0 then
    begin
      ResponseStream.Position := 0;
      Response := TJson.JsonToObject<TImgBBUploadResponse>(ResponseStream.DataString);
    end
    else
      raise Exception.Create('Response is empty');
  finally
    ResponseStream.Free;
    Body.Free;
    Client.Free;
  end;
end;

function TImgBB.Upload(const FileName: string; const Name: string; Expiration: Integer): TImgBBUploadResponse;
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmShareDenyWrite);
  try
    Result := Upload(FileStream, FileName, Response, Name, Expiration);
  finally
    FileStream.Free;
  end;
end;

function TImgBB.Upload(const Stream: TStream; const FileName: string; const Name: string; Expiration: Integer): string;
var
  Response: TImgBBUploadResponse;
begin
  Result := Upload(Stream, FileName, Response, Name, Expiration);
  if Assigned(Response) then
  try
    if Result then
      ImageUrl := Response.Data.Url;
  finally
    Response.Free;
  end;
end;

function TImgBB.Upload(const FileName: string; const Name: string; Expiration: Integer): string;
var
  Response: TImgBBUploadResponse;
begin
  Result := Upload(FileName, Response, Name, Expiration);
  if Assigned(Response) then
  try
    if Result then
      ImageUrl := Response.Data.Url;
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

