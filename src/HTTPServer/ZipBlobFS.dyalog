:Class ZipBlobFS

    :field public instance _mem
    :field public instance _zip
    :field public instance _names
    :field public instance NoCase

    ∇ make blob;iS;System;ZipArchive;ZipArchiveMode
⍝ blob must be a type 83 vector
      :Access public instance
      :Implements constructor
      ⎕USING←'' 'System.IO.Compression,System.IO.Compression.dll' ⍝'System.IO.Compression,System.IO.Compression.FileSystem.dll'
     
      iS←⎕NEW System.IO.MemoryStream((256|blob)0)
      _zip←⎕NEW ZipArchive(iS ZipArchiveMode.Read 0)
      Init
    ∇

    ∇ Init
:access public instance
      NoCase←0
      _names←_zip.(⌷Entries).FullName
    ∇

    int←{↑⍵{(⍺|⍵+⍺⍺)-⍵}/2*⍺-0 1}

    ∇ r←{nocase}GetContent name;i;o;norm
      :Access public instance
      :If 0=⎕NC'nocase'
          nocase←NoCase
      :EndIf
      norm←(819⌶)⍣nocase
      i←(norm _names)#.io0.⍳⊂norm name
      :Disposable o←_zip.Entries[i].Open
          r←8 int #._OS.StreamToArray o
      :EndDisposable
    ∇

    ∇ b←{nocase}Exists names;norm
      :Access public instance
      :If 0=⎕NC'nocase'
          nocase←NoCase
      :EndIf
      norm←(819⌶)⍣nocase
      :Access public instance
      b←(norm #.nested names)∊norm _names
    ∇

    ∇ dispose
      :Implements destructor
      :Trap 0
          :Disposable _zip
          :EndDisposable
      :EndTrap
    ∇

:EndClass
