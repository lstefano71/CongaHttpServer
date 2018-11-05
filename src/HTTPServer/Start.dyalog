 srv←(cfg Start)_;secureParams;rc;r;Port;BlockSize
 #.uGSTK',ADC3'

 srv←⎕NS''
 srv.CongaRoot←#.Conga.New''
 srv.Logging←0
 srv.Secure←0
 srv.Debug←0
 srv.Stop←⎕THIS.{Stop ⍵}∘srv
 secureParams←⍬
 Port←8080
 BlockSize←10000

 :If 98 10048∊⍨rc←1⊃r←srv.CongaRoot.Srv'' ''Port'http'BlockSize,secureParams ⍝ 98=Linux, 10048=Windows
     ∘∘∘ ⍝     CheckRC(rc msg)←10('Server could not start - port ',(⍕Port),' is already in use')
 :ElseIf 0=rc
     srv.(Started Stopped _stop)←1 0 0
     srv.ServerName←2⊃r
     {}srv.CongaRoot.SetProp'.' 'EventMode' 1 ⍝ report Close/Timeout as events
     {}srv.CongaRoot.SetProp srv.ServerName'FIFOMode' 0
     {}srv.CongaRoot.SetProp srv.ServerName'DecodeBuffers' 15 ⍝ decode all buffers
     srv.Connections←#.⎕NS''
     (cfg Build)srv
     srv.TID←Server&srv
⍝     msg←''
 :Else
     ∘∘∘ ⍝      CheckRC rc'Error creating server'
 :EndIf


 #.uGSTK 0
⍝∘ (c)APLIT S HTP stf 02/11/2018 15:05                30682 D95
