 type←MimeType ext

 type←(MIMETYPES[;2],⎕NULL)⊃⍨MIMETYPES[;1]⍳⊂#.LOWERCASE ext
⍝∘ (c)APLIT S HTP stf 02/11/2018 21:36                 9083 D95
