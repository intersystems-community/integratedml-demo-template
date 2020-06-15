Class Util.Loader
{

ClassMethod Load(pFile As %String, pClass As %String, pSeparator As %String = ",") As %Status
{
	set tSC = $$$OK
	try {
		do $classmethod(pClass,"%KillExtent")
		set tClassDef = ##class(%Dictionary.ClassDefinition).%OpenId(pClass)
		for i=1:1:tClassDef.Properties.Count() {
			set tProp = tClassDef.Properties.GetAt(i)
			set tProps($$$UPPER(tProp.Name)) = tProp.Name
			set tPropTypes($$$UPPER(tProp.Name)) = tProp.Type
		}
		
		set tFile = ##class(%Stream.FileCharacter).%New()
		do tFile.LinkToFile(pFile)
		set tHeader = $zstrip(tFile.ReadLine(),"<>WC")
		for i = 1:1:$l(tHeader,pSeparator) {
			set h = $p(tHeader,pSeparator,i)
			quit:h=""
			set tColumns($i(tColumns))=tProps($$$UPPER($tr(h,"_"))),
				tTypes(tColumns) = tPropTypes($$$UPPER($tr(h,"_")))
		}
		
		while 'tFile.AtEnd {
			set tLine = $zstrip(tFile.ReadLine(),"<>WC")
			continue:tLine=""
			
			set tObj = $classmethod(pClass,"%New")
			for i=1:1:tColumns {
				set tValue = $piece(tLine,pSeparator,i)
				set:tTypes(i)="%Library.Date" tValue = $zdateh($tr(tValue,"/","-"),3)
				set $property(tObj, tColumns(i)) = tValue
			}
			set tSC = tObj.%Save()
			quit:$$$ISERR(tSC)
			set c = $i(c)
		}
		quit:$$$ISERR(tSC)
		
		write !,"Read ",c," records for table ",pClass,!
		
	} catch (ex) {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

}
