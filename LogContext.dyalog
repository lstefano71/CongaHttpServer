 {r}←ctx LogContext arg;obj
 ⎕←'[',(⍕⎕TID),'] === Start Request: ',obj←ctx.Object
 ⎕←ctx.Request.(Path PathBase Method)

 r←arg.Next ctx

 :If 0 ⍝ 0=⎕THIS('DEBUG'#.uQV)arg.Debug
     ⎕←ctx.Response.(Status StatusText(≢Body)Headers)
     ⎕←'[',(⍕⎕TID),'] Time: ',⍕⎕AI[3]-ctx.Start
     ⎕←'[',(⍕⎕TID),'] === End Request: ',obj
 :EndIf
⍝∘ (c)APLIT S HTP stf 02/11/2018 19:02                19235 D95
