program NeatoToolio;
{$R *.dres}

uses
  madExcept,
  madLinkDisAsm,
  madListHardware,
  madListProcesses,
  madListModules,
  System.StartUpCopy,
  FMX.Forms,
  fmx.types,
  dmSerial.Windows in 'dmSerial.Windows.pas' {dmSerial: TDataModule},
  dmCommon in 'dmCommon.pas' {dm: TDataModule},
  formMain in 'formMain.pas' {frmMain},
  XSuperJSON in 'XSuperJSON\XSuperJSON.pas',
  XSuperObject in 'XSuperJSON\XSuperObject.pas',
  neato.Commands in 'common\neato.Commands.pas',
  neato.Errors in 'common\neato.Errors.pas',
  neato.Helpers in 'common\neato.Helpers.pas',
  neato.Settings in 'common\neato.Settings.pas',
  neato.D.ClearFiles in 'DSeries\neato.D.ClearFiles.pas',
  neato.D.GetAnalogSensors in 'DSeries\neato.D.GetAnalogSensors.pas',
  neato.D.GetButtons in 'DSeries\neato.D.GetButtons.pas',
  neato.D.GetCalInfo in 'DSeries\neato.D.GetCalInfo.pas',
  neato.D.GetCharger in 'DSeries\neato.D.GetCharger.pas',
  neato.D.GetDigitalSensors in 'DSeries\neato.D.GetDigitalSensors.pas',
  neato.D.GetErr in 'DSeries\neato.D.GetErr.pas',
  neato.D.GetMotors in 'DSeries\neato.D.GetMotors.pas',
  neato.D.GetUsage in 'DSeries\neato.D.GetUsage.pas',
  neato.D.GetUserSettings in 'DSeries\neato.D.GetUserSettings.pas',
  neato.D.GetVersion in 'DSeries\neato.D.GetVersion.pas',
  neato.D.GetWarranty in 'DSeries\neato.D.GetWarranty.pas',
  neato.D.GetWifiInfo in 'DSeries\neato.D.GetWifiInfo.pas',
  neato.D.GetWifiStatus in 'DSeries\neato.D.GetWifiStatus.pas',
  neato.D.TestLDS in 'DSeries\neato.D.TestLDS.pas',
  neato.XV.GetAnalogSensors in 'XVSeries\neato.XV.GetAnalogSensors.pas',
  neato.XV.GetCharger in 'XVSeries\neato.XV.GetCharger.pas',
  neato.XV.GetLDSScan in 'XVSeries\neato.XV.GetLDSScan.pas',
  neato.DXV.Playsound in 'Common\neato.DXV.Playsound.pas',
  neato.XV.GetDigitalSensors in 'XVSeries\neato.XV.GetDigitalSensors.pas',
  neato.D.GetSensor in 'DSeries\neato.D.GetSensor.pas',
  frame.D.GetAnalogSensors in 'DSeriesFrames\frame.D.GetAnalogSensors.pas' {frameDGetAnalogSensors: TFrame},
  frame.D.GetButtons in 'DSeriesFrames\frame.D.GetButtons.pas' {frameDGetButtons: TFrame},
  frame.D.GetCalInfo in 'DSeriesFrames\frame.D.GetCalInfo.pas' {frameDGetCalInfo: TFrame},
  frame.D.GetCharger in 'DSeriesFrames\frame.D.GetCharger.pas' {frameDGetCharger: TFrame},
  frame.D.GetDigitalSensors in 'DSeriesFrames\frame.D.GetDigitalSensors.pas' {frameDGetDigitalSensors: TFrame},
  frame.D.GetMotors in 'DSeriesFrames\frame.D.GetMotors.pas' {frameDGetMotors: TFrame},
  frame.D.GetWarranty in 'DSeriesFrames\frame.D.GetWarranty.pas' {frameDGetWarranty: TFrame},
  frame.D.GetErr in 'DSeriesFrames\frame.D.GetErr.pas' {FrameDGetErr: TFrame},
  frame.D.GetVersion in 'DSeriesFrames\frame.D.GetVersion.pas' {frameDGetVersion: TFrame},
  frame.D.GetUsage in 'DSeriesFrames\frame.D.GetUsage.pas' {frameDGetUsage: TFrame},
  frame.D.GetUserSettings in 'DSeriesFrames\frame.D.GetUserSettings.pas' {frameDGetUserSettings: TFrame},
  frame.D.ClearFiles in 'DSeriesFrames\frame.D.ClearFiles.pas' {frameDClearFiles: TFrame},
  frame.D.GetWifiInfo in 'DSeriesFrames\frame.D.GetWifiInfo.pas' {frameDGetWifiInfo: TFrame},
  frame.D.GetWifiStatus in 'DSeriesFrames\frame.D.GetWifiStatus.pas' {frameDGetWifiStatus: TFrame},
  frame.XV.GetCharger in 'XVSeriesFrames\frame.XV.GetCharger.pas' {frameXVGetCharger: TFrame},
  frame.DXV.Terminal in 'CommonFrames\frame.DXV.Terminal.pas' {frameDXVTerminal: TFrame},
  frame.DXV.Playsound in 'CommonFrames\frame.DXV.Playsound.pas' {frameDXVPlaySound: TFrame},
  frame.XV.GetAnalogSensors in 'XVSeriesFrames\frame.XV.GetAnalogSensors.pas' {frameXVGetAnalogSensors: TFrame},
  frame.XV.GetDigitalSensors in 'XVSeriesFrames\frame.XV.GetDigitalSensors.pas' {frameXVGetDigitalSensors: TFrame},
  frame.D.GetSensors in 'DSeriesFrames\frame.D.GetSensors.pas' {frameDGetSensors: TFrame},
  frame.Scripts in 'Scripts\frame.Scripts.pas' {frameScripts: TFrame},
  neato.XV.GetMotors in 'XVSeries\neato.XV.GetMotors.pas',
  frame.XV.GetMotors in 'XVSeriesFrames\frame.XV.GetMotors.pas' {frameXVGetMotors: TFrame},
  frame.XV.GetCalInfo in 'XVSeriesFrames\frame.XV.GetCalInfo.pas' {frameXVGetCalInfo: TFrame},
  neato.XV.GetCalInfo in 'XVSeries\neato.XV.GetCalInfo.pas',
  frame.XV.GetWarranty in 'XVSeriesFrames\frame.XV.GetWarranty.pas' {frameXVGetWarranty: TFrame},
  neato.XV.GetWarranty in 'XVSeries\neato.XV.GetWarranty.pas',
  neato.XV.GetErr in 'XVSeries\neato.XV.GetErr.pas',
  frame.XV.GetErr in 'XVSeriesFrames\frame.XV.GetErr.pas' {FrameXVGetErr: TFrame},
  frame.XV.GetVersion in 'XVSeriesFrames\frame.XV.GetVersion.pas' {frameXVGetVersion: TFrame},
  neato.XV.GetVersion in 'XVSeries\neato.XV.GetVersion.pas',
  frame.XV.RestoreDefaults in 'XVSeriesFrames\frame.XV.RestoreDefaults.pas' {frameXVRestoreDefaults: TFrame},
  neato.XV.RestoreDefaults in 'XVSeries\neato.XV.RestoreDefaults.pas',
  neato.XV.GetButtons in 'XVSeries\neato.XV.GetButtons.pas',
  frame.XV.GetButtons in 'XVSeriesFrames\frame.XV.GetButtons.pas' {frameXVGetButtons: TFrame},
  neato.XV.GetTime in 'XVSeries\neato.XV.GetTime.pas',
  frame.XV.GetTime in 'XVSeriesFrames\frame.XV.GetTime.pas' {frameXVGetTime: TFrame},
  neato.XV.Clean in 'XVSeries\neato.XV.Clean.pas',
  frame.XV.Clean in 'XVSeriesFrames\frame.XV.Clean.pas' {frameXVClean: TFrame},
  neato.DXV.GetLDSScan in 'Common\neato.DXV.GetLDSScan.pas',
  frame.DXV.GetLDSScan in 'CommonFrames\frame.DXV.GetLDSScan.pas' {frameDXVGetLDSScan: TFrame},
  neato.DXV.SetFuelGauge in 'Common\neato.DXV.SetFuelGauge.pas',
  frame.DXV.SetFuelGauge in 'CommonFrames\frame.DXV.SetFuelGauge.pas' {frameDXVSetFuelGauge: TFrame},
  frame.DXV.GetAccel in 'CommonFrames\frame.DXV.GetAccel.pas' {frameDXVGetAccel: TFrame},
  neato.DXV.GetAccel in 'Common\neato.DXV.GetAccel.pas',
  neato.DXV.SetTime in 'Common\neato.DXV.SetTime.pas',
  frame.DXV.SetTime in 'CommonFrames\frame.DXV.SetTime.pas' {frameDXVSetTime: TFrame},
  frame.DXV.SetSystemMode in 'CommonFrames\frame.DXV.SetSystemMode.pas' {frameDXVSetSystemMode: TFrame},
  neato.DXV.SetSystemMode in 'Common\neato.DXV.SetSystemMode.pas',
  neato.DXV.SetLCD in 'Common\neato.DXV.SetLCD.pas',
  frame.DXV.SetLCD in 'CommonFrames\frame.DXV.SetLCD.pas' {frameDXVSetLCD: TFrame},
  frame.DXV.SetLED in 'CommonFrames\frame.DXV.SetLED.pas' {frameDXVSetLED: TFrame},
  neato.DXV.SetLED in 'Common\neato.DXV.SetLED.pas',
  neato.XV.GetSchedule in 'XVSeries\neato.XV.GetSchedule.pas',
  frame.XV.GetSchedule in 'XVSeriesFrames\frame.XV.GetSchedule.pas' {frameXVGetSchedule: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
