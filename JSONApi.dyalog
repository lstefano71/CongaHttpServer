 r←ctx(apiroot JSONApi)arg;x;j;y;body

 r←0
 :If ~0∊⍴body←ctx.Request.Body
     y←0 ⎕JSON body
 :Else
     y←⍬
 :EndIf
 :If 9=⎕NC'apiroot'
     x←ctx(apiroot⍎1↓ctx.Request.Path)y
 :Else
     x←ctx apiroot y
 :EndIf

 j←1 ⎕JSON x
 ctx SetBody j

 ctx.Response SetHeader'Content-Type' 'application/json; charset=utf-8'
⍝ TODO: CORS middleware
 ctx.Response SetHeader'Access-Control-Allow-Origin'(,'*')
⍝∘ (c)APLIT S HTP stf 05/11/2018 11:16                28291 D95
