 r←ctx Empty arg
 r←0
 ctx.Response SetHeader'Content-Type' 'application/json; charset=utf-8'
 ctx SetBody'{ status: "OK", Timestamp: "',(⍕⎕TS),'", "Path": "',(ctx.Request.Path),'" }'
⍝∘ (c)APLIT S HTP stf 02/11/2018 16:01                 1077 D95
