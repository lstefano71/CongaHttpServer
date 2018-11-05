 (apiroot JSONServer)app;Debug;log;api


 log←app(LogError Use)⍬
 log.Debug←0

 app(LogContext Use)⍬

 app UseCompression ⍬

 api←apiroot{
     ⍵(⍺⍺ JSONApi Run)⍬
 }

 app(api Map'/api')⍬

⍝∘ (c)APLIT S HTP stf 05/11/2018 11:16                13037 D95
