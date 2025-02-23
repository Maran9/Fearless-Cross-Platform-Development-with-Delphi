unit udmParksDB;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.ConsoleUI.Wait, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.Phys.IBBase;

type
  TdmParksDB = class(TDataModule)
    FDParkConnection: TFDConnection;
    qryParkLookup: TFDQuery;
    qryParkLookupPARK_ID: TIntegerField;
    qryParkLookupPARK_NAME: TStringField;
    qryParkLookupLONGITUDE: TFMTBCDField;
    qryParkLookupLATITUDE: TFMTBCDField;
    FDPhysIBDriverLink: TFDPhysIBDriverLink;
  public
    type
      TParkDataRec = record
        ParkID: Integer;
        ParkName: string;
        Longitude: Double;
        Latitude: Double;
        procedure Clear;
      end;
    function LookupParkByLocation(const ALongitude, ALatitude: Double): TParkDataRec;
  end;

var
  dmParksDB: TdmParksDB;

implementation

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

uses
  uMyParksLogging;

const
  LOG_TAG = 'database';

{ TdmParksDB }

function TdmParksDB.LookupParkByLocation(const ALongitude, ALatitude: Double): TParkDataRec;
begin
  Log.Info(Format('LookupParkByLocation(%f, %f)', [ALongitude, ALatitude]), LOG_TAG);

  Result.Clear;

  try
    qryParkLookup.Prepare;
    qryParkLookup.ParamByName('long').AsSingle := ALongitude;
    qryParkLookup.ParamByName('lat').AsSingle  := ALatitude;
    qryParkLookup.Open;

    if qryParkLookup.RecordCount > 0 then begin
      Result.ParkID := qryParkLookupPARK_ID.AsInteger;
      Result.ParkName := qryParkLookupPARK_NAME.AsString;
      Result.Longitude := qryParkLookupLONGITUDE.AsFloat;
      Result.Latitude  := qryParkLookupLATITUDE.AsFloat;
    end;
  finally
    qryParkLookup.Close;
  end;

  Log.Info(Format('  returning ParkID=%d, ParkName=%s', [Result.ParkID, Result.ParkName]), LOG_TAG);
end;

{ TdmParksDB.TParkDataRec }

procedure TdmParksDB.TParkDataRec.Clear;
begin
  ParkID := -1;
  ParkName := EmptyStr;
  Longitude := 0;
  Latitude  := 0;
end;

initialization
  dmParksDB := TdmParksDB.Create(nil);
finalization
  dmParksDB.Free;
end.
