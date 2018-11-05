:Class PhysicalFS

    :field public instance _root

    ∇ make root
⍝ blob must be a type 83 vector
      :Access public instance
      :Implements constructor
      _root←root
    ∇


    ∇ r←GetContent name;t;fname
      :Access public instance
      fname←_root #._OS.JoinPath name
      t←fname ⎕NTIE 0 64
      r←⎕NREAD t,83,¯1
      ⎕NUNTIE t
    ∇

    ∇ b←Exists names
      :Access public instance
b←      #.PLUS.nexists _root∘#._OS.JoinPath¨#.nested names
    ∇

    ∇ dispose
      :Implements destructor
      :Trap 0
          :Disposable _zip
          :EndDisposable
      :EndTrap
    ∇

:EndClass
