 {ns}←app(mdw Run)arg

 ns←⎕NS''
 ns.Type←'Run'
 ns.Arg←arg
 ns.Do←mdw
 app.Pipeline,←ns
⍝∘ (c)APLIT S HTP stf 02/11/2018 14:38                 6104 D95
