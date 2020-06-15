Class NLP.HateSpeech Extends %Persistent
{

Property Comment As %String(MAXLEN = "");

Property FileName As %String;

Property UserId As %String;

Property SubforumId As %String;

Property ContextNeeded As %Integer;

// training or test

Property Sample As %String;

Property Label As %String;

ClassMethod Load(pDir As %String = "C:\Users\bdeboe\Documents\GitHub\hate-speech-dataset\") As %Status
{
	set tSC = $$$OK
	try {
		do ..%KillExtent()
		
		set tSeparator = $s($$$isWINDOWS:"\",1:"/")
		set tFile = ##class(%Stream.FileCharacter).%New()
		set tSC = tFile.LinkToFile(pDir_"annotations_metadata.csv")
		quit:$$$ISERR(tSC)
		
		do tFile.ReadLine() // skip header
		
		while 'tFile.AtEnd {
			set tLine = $zstrip(tFile.ReadLine(),"<>WC")
			set tRow = ..%New()
			set tRow.FileName = $piece(tLine,",",1)_".txt"
			set tRow.UserId = $piece(tLine,",",2)
			set tRow.SubforumId = $piece(tLine,",",3)
			set tRow.ContextNeeded = $piece(tLine,",",4)
			set tRow.Label = $piece(tLine,",",5)
			
			set tCommentFile = ##class(%Stream.FileCharacter).%New()
			set tSC = tCommentFile.LinkToFile(pDir_"all_files"_tSeparator_tRow.FileName)
			quit:$$$ISERR(tSC)
			set tRow.Comment = tCommentFile.Read()
			
			if ##class(%File).Exists(pDir_"sampled_train"_tSeparator_tRow.FileName) {
				set tRow.Sample = "train"
			} elseif ##class(%File).Exists(pDir_"sampled_test"_tSeparator_tRow.FileName) {
				set tRow.Sample = "test"
			}
			
			set tSC = tRow.%Save()
			quit:$$$ISERR(tSC)
		}
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

Storage Default
{
<Data name="HateSpeechDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Comment</Value>
</Value>
<Value name="3">
<Value>FileName</Value>
</Value>
<Value name="4">
<Value>UserId</Value>
</Value>
<Value name="5">
<Value>SubforumId</Value>
</Value>
<Value name="6">
<Value>ContextNeeded</Value>
</Value>
<Value name="7">
<Value>Label</Value>
</Value>
<Value name="8">
<Value>Sample</Value>
</Value>
</Data>
<DataLocation>^NLP.HateSpeechD</DataLocation>
<DefaultData>HateSpeechDefaultData</DefaultData>
<IdLocation>^NLP.HateSpeechD</IdLocation>
<IndexLocation>^NLP.HateSpeechI</IndexLocation>
<StreamLocation>^NLP.HateSpeechS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
