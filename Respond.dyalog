 r←srv Respond ctx;status;z;res;obj;srv;t_
 res←ctx.Response
 status←(⊂'HTTP/1.1'),res.((⍕Status)StatusText)
 obj←ctx.Object

⍝ TODO:
⍝ :If res.Status≠200 ⍝ if failed response, replace headers
⍝     res.Headers←1 2⍴'content-type' 'text/html'
⍝ :EndIf

⍝ TODO:
⍝ res.Headers⍪←'server'(⊃Version)

 res.Headers⍪←'Date'(2⊃srv.CongaRoot.GetProp'.' 'HttpDate')
 :If srv.Logging
     ⎕←('G⊂9999/99/99 @ 99:99:99⊃'⎕FMT 100⊥6↑⎕TS)status res.Headers res.JSON
 :EndIf

 :If 0≠1⊃z←srv.CongaRoot.Send obj(status,res.Headers res.Body)1
     ⎕←'⍝ Error sending Response: 'z
 :EndIf

⍝ TODO
⍝ :If 0≠1⊃z←srv.CongaRoot.Send obj(status,res.Headers res.JSON)1
⍝ TODO
⍝     Log'Conga error when sending response',GetIP obj
⍝     Log⍕z
⍝ :EndIf
⍝ TODO: HTTP 1.1 reuse connection

 srv.Connections.⎕EX obj
 r←1
⍝∘ (c)APLIT S HTP stf 02/11/2018 17:54                19405 D95
