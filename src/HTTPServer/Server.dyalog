 Server srv;wres;rc;obj;evt;data;ref;ip;tids
 tids←⍬
 :While ~srv._stop
     wres←srv.CongaRoot.Wait srv.ServerName 2500 ⍝ Wait for WaitTimeout before timing out
          ⍝ wres: (return code) (object name) (command) (data)
     (rc obj evt data)←4↑wres
     tids←tids∩⎕TNUMS
     :Select rc
     :Case 0
         :Select evt
         :Case 'Error'
             ⎕←rc obj evt
             srv._stop←srv.ServerName≡obj
             :If 0≠4⊃wres
⍝ TODO:
                 ⎕←'RunServer: DRC.Wait reported error ',(⍕#.Conga.Error 4⊃wres) ⍝ ,' on ',(2⊃wres),GetIP obj
             :EndIf
             srv.Connections.⎕EX obj

         :Case 'Connect'
             obj srv.Connections.⎕NS''
             (srv.Connections⍎obj).IP←2⊃2⊃srv.CongaRoot.GetProp obj'PeerAddr'

         :CaseList 'HTTPHeader' 'HTTPTrailer' 'HTTPChunk' 'HTTPBody'
 ⍝ TODO
             tids,←(srv.Connections⍎obj){
                 srv rc obj←3↑⍵
                 t←⍺ HandleRequest ⍵
                 srv.Connections.⎕EX obj
             }&srv,wres
         :Case 'Closed'
             ⎕←rc obj evt
         :Case 'Timeout'
               ⍝ nop
         :Else ⍝ unhandled event
             ∘∘∘
             Log'Unhandled Conga event:'
             Log⍕wres
         :EndSelect ⍝ evt

     :Case 1010 ⍝ Object Not found
         ⎕←'Object ''',srv.ServerName,''' has been closed - Web Server shutting down'
         →0

     :Else
     ⍝ TODO:
         ⍝Log'Conga wait failed:'
         ⍝ Log wres
     :EndSelect ⍝ rc
 :EndWhile
 ⎕TKILL tids
 {}srv.CongaRoot.Close srv.ServerName
 srv.Stopped←1
 srv.⎕EX'CongaRoot'
⍝∘ (c)APLIT S HTP stf 02/11/2018 17:31                17479 D95
