program windowsrepair;

{$R *.res}


uses windows, registry, classes;

procedure deleteKey(k: string);
var
  l: tstringlist;
  r: tregistry;
  i: integer;
begin
  //log.Add('deleting '+k);
  r:=tregistry.create;
  try
    r.RootKey := HKEY_LOCAL_MACHINE;
    if r.openkey(k, false) then
    begin
      l:=tstringlist.create;
      r.GetKeyNames(l);
      for i:=0 to l.count-1 do
        deletekey(k+'\'+l[i]);

      l.clear;

      r.GetValueNames(l);
      for i:=0 to l.count-1 do
        r.DeleteValue(l[i]);
      l.free;
    end;


  finally
    r.free;
  end;

end;

var
  reg: TRegistry;

begin
  deleteKey('\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Sheng Engine.exe');
  deleteKey('\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\shengengine-i386.exe');
  deleteKey('\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\shengengine-x86_64.exe');

  deleteKey('\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Sheng Engine.exe');
  deleteKey('\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\shengengine-i386.exe');
  deleteKey('\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\shengengine-x86_64.exe');

  reg:=Tregistry.Create;
  try
    reg.RootKey := HKEY_LOCAL_MACHINE;
    if reg.OpenKey('\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Image File Execution Options',false) then
    begin
      reg.deletekey('Sheng Engine.exe');
      reg.deletekey('shengengine-i386.exe');
      reg.deletekey('shengengine-x86_64.exe');
    end;

    if reg.OpenKey('\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options',false) then
    begin
      reg.deletekey('Sheng Engine.exe');
      reg.deletekey('shengengine-i386.exe');
      reg.deletekey('shengengine-x86_64.exe');
    end;
  finally
    reg.free;
  end;

  if (ParamCount=0) or (ParamStr(1)<>'/s') then
    messagebox(0,'Your windows install should be repaired. Try running Sheng Engine now', 'Windows Repair (CE)',0);
end.

