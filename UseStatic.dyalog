 app UseStatic(path filesys);vfs;bld

 :If #.IsChar filesys
     vfs←⎕NEW PhysicalFS(filesys)
 :ElseIf 2=≢filesys
     :Select ⊃filesys
     :Case 'zipblob'
         vfs←⎕NEW ZipBlobFS(2⊃filesys)
     :Case 'zip'
         vfs←⎕NEW ZipFS(2⊃filesys)
     :Else
         ∘∘∘
     :EndSelect
 :Else
     vfs←filesys
 :EndIf
 bld←vfs{
     ⍵(VFS Run)⍺⍺
 }
 app(bld Map path)⍬
⍝∘ (c)APLIT S HTP stf 05/11/2018 11:34                10664 D95
