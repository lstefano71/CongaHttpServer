:Class ZipFS : ZipBlobFS

    ∇ make fname;System;ZipFile;ZipArchiveMode
      :Access public instance
      :Implements constructor
      ⎕USING←'' 'System.IO.Compression,System.IO.Compression.dll' 'System.IO.Compression,System.IO.Compression.FileSystem.dll'
     
      _zip←ZipFile.OpenRead(⊂fname)
      Init
    ∇

:EndClass
