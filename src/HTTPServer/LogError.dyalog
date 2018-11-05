 {r}←ctx LogError arg;⎕TRAP;html;fmt
⍝ TODO
 r←0
⍝  ⎕←'Debug: ',⍕arg.Debug
 :Trap (0=⎕THIS('DEBUG'#.uQV)arg.Debug)/0 1000
     r←arg.Next ctx
 :Else
     ⎕←⎕DMX
     ⍝ TODO
     ctx.Response.(Status StatusText)←500 'KO'
     fmt←{(⎕XML ⎕OPT'Whitespace' 'Preserve')0 ⍺ ⍵}
     html←'pre'fmt,#.PLUS.xsi #.uCAT ⎕UCS 13 10
     html,⍨←'<h1>Internal Error</h1>','pre'fmt,(⍕⎕DMX)#.uCAT ⎕UCS 13 10
     ctx SetBody html
     ctx.Response SetHeader'Content-Type' 'text/html; charset=utf-8'
     ⍝ Respond 500
 :EndTrap
⍝∘ (c)APLIT S HTP stf 02/11/2018 18:47                 4315 D95
