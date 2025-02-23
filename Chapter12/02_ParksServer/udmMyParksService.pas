unit udmMyParksService;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs;

type
  TMyParksIBService = class(TService)
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServiceAfterUninstall(Sender: TService);
  public
    function GetServiceController: TServiceController; override;
  end;

var
  MyParksIBService: TMyParksIBService;

implementation

{$R *.dfm}

uses
  System.Win.Registry,
  LoggerPro.GlobalLogger,
  udmTCPParksServer;

const
  LOG_TAG = 'service';

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  MyParksIBService.Controller(CtrlCode);
end;

function TMyParksIBService.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TMyParksIBService.ServiceAfterInstall(Sender: TService);
var
  Reg: TRegistry;
begin
  Log.Info('Installed', LOG_TAG);

  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + Name, False) then begin
      Reg.WriteString('Description', 'Listens for Longitude and Latitude data, returns the matching park name.');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TMyParksIBService.ServiceAfterUninstall(Sender: TService);
begin
  Log.Info('Uninstalled', LOG_TAG);
end;

procedure TMyParksIBService.ServiceStart(Sender: TService; var Started: Boolean);
begin
  dmTCPParksServer.Start;
  Log.Info('Started', LOG_TAG);
end;

procedure TMyParksIBService.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  dmTCPParksServer.Stop;
  Log.Info('Stopped', LOG_TAG);
end;

end.
