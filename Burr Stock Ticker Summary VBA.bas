Attribute VB_Name = "Module1"
Sub ticker_count()

' ** Loop through worksheets**

    Sheets(1).Select
    For Each ws In Worksheets
    
    ' **Declare variables**
    Dim n As Long
    Dim i As Long
    Dim total As Variant
    Dim open_value As Double
    Dim close_value As Double
    Dim change As Double
    Dim percent As Variant
    
    Dim TheMax As Double
    Dim TheMin As Double
    Dim MaxVol As Variant
    
    ' **Define Start Variables**
    ' locate last row in column A
    n = ws.Cells(Rows.Count, 1).End(xlUp).Row
    
    ' Count number of tickers for Table Summary
    r = 2
    
    ' Add up the value of the Ticker
    total = 0
    
    ' select first opening value of first stock
    open_value = ws.Cells(2, 3).Value
     
    ' **Develop Summary Table**
    'create Yearly Change table
    ws.Range("I1").Value = "Ticker"
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percent Change"
    ws.Range("L1").Value = "Total Stock Volume"
    
    'create Min/Max table
    ws.Range("O2") = "Greatest % Increase"
    ws.Range("O3") = "Greatest % Decrease"
    ws.Range("O4") = "Greatest Total Volume"
    
    'populate Yearly Change table
        On Error Resume Next
        For i = 2 To n
            
            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
                
                ws.Cells(r, 9).Value = ws.Cells(i, 1).Value
                
                total = total + ws.Cells(i, 7).Value
                
                ws.Cells(r, 12).Value = total
                
                'calculate and present change
                close_value = ws.Cells(i, 6).Value
                change = close_value - open_value
                percent = Round(change / open_value, 4)
                ws.Cells(r, 10).Value = change
                ws.Cells(r, 11).Value = percent
                
               ' format change column
               
                    If ws.Cells(r, 10) < 0 Then
                        ws.Cells(r, 10).Interior.ColorIndex = 3
                    
                    Else
                        ws.Cells(r, 10).Interior.ColorIndex = 4
                    
                    End If
                
                'Format percent column
                ws.Cells(r, 11).NumberFormat = "0.00%"
               
                'store opening value for next i
                open_value = ws.Cells(i + 1, 3).Value
            
                'reset variables
                r = r + 1
                total = 0
                
            Else
            
                total = total + ws.Cells(i, 7).Value
            
            End If
        
        'format percent change column

          
        Next i
        
    'populate Min/max Table
    TheMax = WorksheetFunction.Max(ws.Range("K:K"))
    TheMin = WorksheetFunction.Min(ws.Range("K:K"))
    MaxVol = WorksheetFunction.Max(ws.Range("L:L"))
    
    For i = 2 To r
        If ws.Cells(i, 11).Value = TheMax Then
        
            ws.Range("P2").Value = (ws.Cells(i, 9).Value)
            ws.Range("Q2").Value = TheMax
            ws.Range("Q2").NumberFormat = "0.00%"
        
        ElseIf ws.Cells(i, 11).Value = TheMin Then
            
            ws.Range("P3").Value = (ws.Cells(i, 9).Value)
            ws.Range("Q3").Value = TheMin
            ws.Range("Q3").NumberFormat = "0.00%"
            
        End If

        If ws.Cells(i, 12).Value = MaxVol Then
        
            ws.Range("P4").Value = (ws.Cells(i, 9).Value)
            ws.Range("Q4").Value = MaxVol
        
        End If
    Next i
    
    ws.Columns("I:Q").AutoFit
    
    Next ws

End Sub

