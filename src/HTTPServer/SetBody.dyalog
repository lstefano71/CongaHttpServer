 ctx SetBody v;gz
⍝ TODO
 :If 326≡⎕DR v
     ∘∘∘
 :ElseIf #.IsChar v
     ctx.Response.Body←{⍵-256×⍵>127}'UTF-8'⎕UCS v
 :Else
     ctx.Response.Body←v
 :EndIf

⍝∘ (c)APLIT S HTP stf 02/11/2018 19:00                30799 D95
