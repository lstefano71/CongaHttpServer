 {ns}←app(cfg MapWhen cond)arg;sub;map

 ns←⎕NS''
 ns.Type←'MapWhen'
 ns.Arg←arg

 sub←⎕NS''
 (cfg Build)sub

 map←sub.Do{
     ⍵⍵ ⍺:⍺⍺ ⍺
     ⍵.Next ⍺
 }cond

 ns.Do←map

 app.Pipeline,←ns
⍝∘ (c)APLIT S HTP stf 02/11/2018 20:48                 5267 D95
