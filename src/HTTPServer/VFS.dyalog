 {r}←ctx VFS arg;vfs;url;t;ext;x
 r←0

 vfs←arg.Arg
 url←1↓ctx.Request.Path

 :If vfs.Exists url
     x←vfs.GetContent url
     ext←1↓⊃⌽#.PLUS.nparts url
     :If ⎕NULL≢t←MimeType ext
         ctx.Response SetHeader'Content-Type't
     :EndIf
     ctx SetBody x
 :Else
     ctx NotFound arg
 :EndIf
⍝∘ (c)APLIT S HTP stf 02/11/2018 22:23                27444 D95
