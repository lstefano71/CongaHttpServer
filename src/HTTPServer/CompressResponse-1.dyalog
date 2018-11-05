 {r}←ctx CompressResponse arg;gz
 r←arg.Next ctx

 :If 'gzip'(1∊⍷)ctx.Request.GetHeader'Accept-Encoding'
     gz←2⊃3.1 #.uCompress ctx.Response.Body

     :If </⎕SIZE↑'gz' 'ctx.Response.Body'
         ctx.Response SetHeader'Content-Encoding' 'gzip'
         ctx.Response SetHeader'Content-MD5'⎕NULL
         ctx.Response.Body←gz
     :EndIf
 :EndIf
⍝∘ (c)APLIT S HTP stf 02/11/2018 17:01                 9622 D95
