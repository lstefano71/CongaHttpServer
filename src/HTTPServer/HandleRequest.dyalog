 r←ctx HandleRequest(srv rc obj evt data);cert;t_
 r←0
 :Hold obj
     :Select evt
     :Case 'HTTPHeader'
         ctx.Start←⎕AI[3]
         ctx.Server←srv
         ctx.Object←obj

         ctx.Request←⎕NEW Request data
         ctx.Request.PeerAddr←2⊃2⊃srv.CongaRoot.GetProp obj'PeerAddr'

         :With ctx.Response←⎕NS''
             Status StatusText←200 'OK'
             Headers←0 2⍴⊂''
             Body←⍬
         :EndWith

         :If srv.Logging
             ⎕←('G⊂9999/99/99 @ 99:99:99⊃'⎕FMT 100⊥6↑⎕TS)data
         :EndIf

         :If srv.Secure
             (rc cert)←2↑srv.CongaRoot.GetProp obj'PeerCert'
             :If rc=0
                 ctx.Request.PeerCert←cert
             :Else
                 ctx.Request.PeerCert←'Could not obtain certificate'
             :EndIf
         :EndIf

     :Case 'HTTPBody'
         ctx.Request.ProcessBody data
         :If srv.Logging
             ⎕←('G⊂9999/99/99 @ 99:99:99⊃'⎕FMT 100⊥6↑⎕TS)data
         :EndIf
     :Case 'HTTPChunk'
         ctx.Request.ProcessChunk data
     :Case 'HTTPTrailer'
         ctx.Request.ProcessTrailer data
     :EndSelect

     :If ctx.Request.Complete
         :If srv.Debug=2  ⍝ framework debug
             ∘∘∘
         :EndIf

⍝ TODO:
⍝             :If 0≠HandleJSONRequest ctx
⍝                 {}srv.CongaRoot.Close obj
⍝                 srv.Connections.⎕EX obj
⍝                 →0
⍝             :EndIf
         ctx RunPipeline srv
         r←srv Respond ctx
     :EndIf
 :EndHold
⍝∘ (c)APLIT S HTP stf 02/11/2018 19:35                27239 D95
