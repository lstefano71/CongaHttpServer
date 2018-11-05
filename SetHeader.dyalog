 replyref SetHeader ctl;tag;content;i;ix;parm;preserve;set;type;val;⎕ML
⍝ update the header list
⍝ ctl←tag content preserve
 tag content preserve←'' '' 0 #.uDefault ctl

 :If content≡⎕NULL
     replyref.Headers⌿⍨←replyref.Headers[;1]≢¨⊂tag
     :Return
 :EndIf

 :If (≢replyref.Headers)<i←replyref.Headers[;1]⍳⊂tag
     replyref.Headers⍪←tag content
 :EndIf
 :If preserve ⍝ Append extra parameters if value matches, e.g. 'text/html' -> 'text/html; charset=UTF-8'
     set←#.DLB¨1↓¨{(';'=⍵)⊂⍵}';',content
     val←#.DLB¨1↓¨{(';'=⍵)⊂⍵}';',⊃replyref.Headers[i;2]

     :If (⊃set)≡type←⊃val ⍝ Existing value matches new. Now append parameters found only in new value.
     :OrIf 0=≢⊃set        ⍝ Not trying to change the value, only appending parameters to existing value.
         val←1↓val
         ix←¯1+val⍳¨'='
         val←↑ix{(⍺↑⍵)(⍺↓⍵)}¨val

         set←1↓set
         ix←¯1+set⍳¨'='
         set←↑ix{(⍺↑⍵)(⍺↓⍵)}¨set

         ix←val[;1]⍳set[;1]
         val⍪←(ix=1+≢val)⌿set

         val[;1]←(⊂'; '),¨val[;1]
         val←#.ml1.∊type,,val
         replyref.Headers[i;2]←⊂val
     :EndIf
 :Else
     replyref.Headers[i;2]←⊂content
 :EndIf
⍝∘ (c)APLIT S HTP stf 02/11/2018 18:45                 9502 D95
