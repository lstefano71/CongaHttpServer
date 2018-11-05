 {ns}←app(cfg Map path)arg;cond
 :If ×≢path
 :AndIf '/'≢⊃path
     ∘∘∘ ⍝ ASSERTION ERROR
 :EndIf

 cond←path∘{
     p←⍵.Request.Path
     b←(⍺≡(≢⍺)↑p)∧('/'≡⊃(≢⍺)↓p)∨((≢⍺)=≢p)
     b:b⊣⍵.Request.(Path PathBase)←((≢⍺)↓⍵.Request.Path)(⍵.Request.PathBase,⍺)
     b
 }

 app(cfg MapWhen cond)arg
⍝∘ (c)APLIT S HTP stf 02/11/2018 22:04                21602 D95
