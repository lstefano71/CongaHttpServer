 (fn Build)app;Do;ns;arg;Arg
 app.Pipeline←⍬
 fn app
 app(NotFound Run)⍬

 Do←{⍵}∘1
 :For ns :In ⌽app.Pipeline
     ns.Next←Do ⍝ {_t←⎕AI[3] ⋄ r←⍺⍺ ⍵ ⋄ ⎕←⍺⍺ ⋄ ⎕←'TID'⎕TID'Time'(⎕AI[3]-_t) ⋄ r}
     Do←ns.Do∘ns
 :EndFor
 app.Do←Do
⍝∘ (c)APLIT S HTP stf 02/11/2018 18:39                 1396 D95
