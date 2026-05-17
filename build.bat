set TP=C:\tp7
set PGE=C:\src

echo Building Static Libraries...

%TP%\bin\tpc.exe -u%TP%\units %PGE%\fx.pas > Nul
%TP%\bin\tpc.exe -u%TP%\units %PGE%\bitmap.pas > Nul
%TP%\bin\tpc.exe -u%TP%\units %PGE%\io.pas > Nul
%TP%\bin\tpc.exe -u%TP%\units %PGE%\video.pas > Nul
%TP%\bin\tpc.exe -u%TP%\units %PGE%\ini.pas > Nul
%TP%\bin\tpc.exe -u%TP%\units %PGE%\mousei.pas > Nul
                                                                                                                                                                                                                              
echo Building PGE...
%TP%\bin\tpc.exe -b -u.\pge -u%TP%\units %PGE%\pge.pas > Nul

cd examples
                                                             
echo Bulding Examples...                                     
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\editor.pas > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\SCRATCH.PAS> Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\GUI.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\CALC.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\CONSOL.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\SLIDER.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\KEYBRD.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\CDROM.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\DEMO.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\SETUP.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\CDAUDIO.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\DEMO2.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\LOADER.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\EDITOR.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\SND.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\PAINTER.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\CIFEDIT.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\CDPLAYER.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\SINWAVE.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\TEMPLATE.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\WINDOW.PAS > Nul
%tp%\bin\tpc.exe -b -u%PGE% -u%tp%\units .\CFG.PAS > Nul                                                   
