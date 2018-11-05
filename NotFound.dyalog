 {r}←ctx NotFound arg;fmt;html
 r←0
 ctx.Response.(Status StatusText)←404 'KO'
 fmt←{(⎕XML ⎕OPT'Whitespace' 'Preserve')0 ⍺ ⍵}
 html←'<h1>Resource not found</h1>','pre'fmt ctx.Request.Path
 ctx SetBody html
 ctx.Response SetHeader'Content-Type' 'text/html; charset=utf-8'
⍝∘ (c)APLIT S HTP stf 02/11/2018 15:49                13930 D95
