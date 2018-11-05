:Class Request
    :Field Public Instance Complete←0        ⍝ do we have a complete request?
    :Field Public Instance Input←''
    :Field Public Instance Host←''           ⍝ host header field
    :Field Public Instance Headers←0 2⍴⊂''   ⍝ HTTPRequest header fields (plus any supplied from HTTPTrailer event)
    :Field Public Instance Method←''         ⍝ HTTP method (GET, POST, PUT, etc)
    :Field Public Instance Path←''           ⍝ Requested URI Decoded
    :Field Public Instance PathBase←''       ⍝ Updated by the middleware

    :field Public Instance Query←''
    :Field Public Instance Body←''           ⍝ body of the request
    :Field Public Instance PeerAddr←'unknown'⍝ client IP address
    :Field Public Instance PeerCert←0 0⍴⊂''  ⍝ client certificate
    :Field Public Instance HTTPVersion←''
    :Field Public Instance Cookies←0 2⍴⊂''

    GetFromTable←{(⍵[;1]⍳⊂lc ,⍺)⊃⍵[;2],⊂''}
    split←{p←(⍺⍷⍵)⍳1 ⋄ ((p-1)↑⍵)(p↓⍵)} ⍝ Split ⍵ on first occurrence of ⍺
    lc←(819⌶)
    begins←{⍺≡(⍴⍺)↑⍵}


    ∇ make args;query;origin;length
      :Access public
      :Implements constructor
      (Method Input HTTPVersion Headers)←args
      Headers[;1]←lc Headers[;1]  ⍝ header names are case insensitive
     
      Host←'host'GetFromTable Headers
      (Path Query)←'?'split Input
      Path←PercentDecode Path
      Complete←('GET'≡Method)∨(length←'content-length'GetFromTable Headers)≡,'0' ⍝ we're a GET or 0 content-length
      Complete∨←(0∊⍴length)>∨/'chunked'⍷'transfer-encoding'GetFromTable Headers ⍝ or no length supplied and we're not chunked
    ∇


    ∇ ProcessBody args
      :Access public
      Body←args
      Complete←1
    ∇

    ∇ ProcessChunk args
      :Access public
        ⍝ args is [1] chunk content [2] chunk-extension name/value pairs (which we don't expect and won't process)
      Body,←1⊃args
    ∇

    ∇ ProcessTrailer args;inds;mask
      :Access public
      args[;1]←lc args[;1]
      mask←(≢Headers)≥inds←Headers[;1]⍳args[;1]
      Headers[mask/inds;2]←mask/args[;2]
      Headers⍪←(~mask)⌿args
      Complete←1
    ∇

    ∇ r←PercentDecode r;rgx;rgxu;i;j;z;t;m;⎕IO;lens;fill
      :Access public shared
        ⍝ Decode a Percent Encoded string https://en.wikipedia.org/wiki/Percent-encoding
      ⎕IO←0
      ((r='+')/r)←' '
      rgx←'[0-9a-fA-F]'
      rgxu←'%[uU]',(4×⍴rgx)⍴rgx ⍝ 4 characters
      r←(rgxu ⎕R{{⎕UCS 16⊥⍉16|'0123456789ABCDEF0123456789abcdef'⍳⍵}2↓⍵.Match})r
      :If 0≠⍴i←(r='%')/⍳⍴r
      :AndIf 0≠⍴i←(i≤¯2+⍴r)/i
          z←r[j←i∘.+1 2]
          t←'UTF-8'⎕UCS 16⊥⍉16|'0123456789ABCDEF0123456789abcdef'⍳z
          lens←⊃∘⍴¨'UTF-8'∘⎕UCS¨t  ⍝ UTF-8 is variable length encoding
          fill←i[¯1↓+\0,lens]
          r[fill]←t
          m←(⍴r)⍴1 ⋄ m[(,j),i~fill]←0
          r←m/r
      :EndIf
    ∇

    ∇ r←GetHeader name
      :Access Public Instance
      r←(lc name)GetFromTable Headers
    ∇

:EndClass
