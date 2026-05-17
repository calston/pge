program edit;
uses {$I PGE.INC}

const FileName='edit.txt';

var MyGUI:TGui;
    MyDesktop:TScreen;

    App:TWin;

    Nothing:TDialog;

    FilePop:TMenu;
    EditPop:TMenu;
    textarea:TEdit;

    done:boolean;
    txtfile:text;

    clip:string;

begin
     assign(txtfile,filename);
     MyDesktop.init;
     MyDesktop.VideoOn;


     App.Make(100,100,200,200,'PGE Editor',200,200);

     FilePop.Make(2,100,'File',App);

     EditPop.Make(52,100,'Edit',App);

     textarea.make(5,50,190,140,app);

     EditPop.AddItem(0,'Copy');
     EditPop.AddItem(1,'Past');
     EditPop.AddItem(2,'Cut');
     EditPop.AddItem(3,void);
     EditPop.AddItem(4,'Clear');

     Filepop.AddItem(0,'New');
     Filepop.AddItem(1,'Open');
     Filepop.AddItem(2,Void);
     Filepop.AddItem(3,'Save');
     Filepop.AddItem(4,'Save As');
     Filepop.AddItem(5,Void);
     Filepop.AddItem(6,'Exit');

{    Nothing.Draw;
     Nothing.Switch;}
               textarea.l:=app.w_l-10;
               textarea.h:=app.w_h-55;
     app.draw;
     textarea.draw;
     Filepop.draw;
     editpop.draw;


     while done=false do
     begin
          if App.WindowClosed=true then done:=true;

          if App.Moved=true then
             begin
                  Filepop.ParentMove(app);
                  textarea.parentMove(app);
               Editpop.ParentMove(app);
             end;

          if App.Resize=true then
          Begin
               Filepop.ParentMove(app);
               Editpop.ParentMove(app);
               textarea.l:=app.w_l-10;
               textarea.h:=app.w_h-55;
               textarea.parentMove(app);
          end;

          if textarea.click=true then NulCmd;

          if FilePop.Open=true then
           begin
                Filepop.destroy;
                if Filepop.clicknum=6 then done:=true;

                if Filepop.clicknum=0 then
                 begin
                      TextArea.Contents:='';
                 end;

                if Filepop.clicknum=1 then
                 begin
                      reset(txtfile);
                      readln(txtfile,TextArea.Contents);
                      close(txtfile);
                 end;

                if Filepop.clicknum=3 then
                 begin
                      rewrite(txtfile);
                      writeln(txtfile,TextArea.Contents);
                      close(txtfile);
                 end;

                if Filepop.clicknum=4 then
                 begin
                      rewrite(txtfile);
                      writeln(txtfile,TextArea.Contents);
                      close(txtfile);
                 end;

                App.draw;
                textarea.draw;
                Filepop.draw;
                EditPop.draw;
           end;

           if EditPop.Open=true then
           begin
                if editpop.clicknum=0 then clip:=textarea.contents;

                if editpop.clicknum=1 then textarea.contents:=textarea.contents+clip;

                if editpop.clicknum=2 then
                begin
                     clip:=textarea.contents;
                     textarea.contents:='';
                end;

                if editpop.clicknum=4 then textarea.contents:='';


                App.draw;
                textarea.draw;
                Filepop.draw;
                EditPop.draw;
           end;
     end;
end.