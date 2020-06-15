/// 
Class User.appointments Extends %Persistent [ ClassType = persistent, DdlAllowed, Final, Owner = {_SYSTEM}, ProcedureBlock, SqlRowIdPrivate, SqlTableName = appointments ]
{

Property ID As %Library.BigInt [ SqlColumnNumber = 2 ];

Property Gender As %Library.String(CONTENT = "STRING", ESCAPE = "XML", JSONTYPE = "string", MAXLEN = 1, TRUNCATE = 0, XSDTYPE = "string") [ SqlColumnNumber = 3 ];

Property ScheduledDay As %Library.Date(JSONTYPE = "string", XSDTYPE = "date") [ SqlColumnNumber = 4 ];

Property AppointmentDay As %Library.Date(JSONTYPE = "string", XSDTYPE = "date") [ SqlColumnNumber = 5 ];

Property Age As %Library.Float(JSONTYPE = "number", XSDTYPE = "double") [ SqlColumnNumber = 6 ];

Property Neighborhood As %Library.String(CONTENT = "STRING", ESCAPE = "XML", JSONTYPE = "string", MAXLEN = 50, TRUNCATE = 0, XSDTYPE = "string") [ SqlColumnNumber = 7 ];

Property Scholarship As %Library.Boolean(JSONTYPE = "boolean", STRICT = 0, XSDTYPE = "boolean") [ SqlColumnNumber = 8 ];

Property Hypertension As %Library.Boolean(JSONTYPE = "boolean", STRICT = 0, XSDTYPE = "boolean") [ SqlColumnNumber = 9 ];

Property Diabetes As %Library.Boolean(JSONTYPE = "boolean", STRICT = 0, XSDTYPE = "boolean") [ SqlColumnNumber = 10 ];

Property Alcoholism As %Library.Boolean(JSONTYPE = "boolean", STRICT = 0, XSDTYPE = "boolean") [ SqlColumnNumber = 11 ];

Property Handicap As %Library.Integer(JSONTYPE = "number", MAXVAL = 2147483647, MINVAL = -2147483648, STRICT = 0, XSDTYPE = "long") [ SqlColumnNumber = 12 ];

Property smsReceived As %Library.Boolean [ SqlColumnNumber = 13 ];

Property noShow As %Library.Boolean [ SqlColumnNumber = 14 ];

Parameter USEEXTENTSET = 1;

Storage Default
{
<Data name="appointmentsDefaultData">
<Value name="1">
<Value>ID</Value>
</Value>
<Value name="2">
<Value>Gender</Value>
</Value>
<Value name="3">
<Value>ScheduledDay</Value>
</Value>
<Value name="4">
<Value>AppointmentDay</Value>
</Value>
<Value name="5">
<Value>Age</Value>
</Value>
<Value name="6">
<Value>Neighborhood</Value>
</Value>
<Value name="7">
<Value>Scholarship</Value>
</Value>
<Value name="8">
<Value>Hypertension</Value>
</Value>
<Value name="9">
<Value>Diabetes</Value>
</Value>
<Value name="10">
<Value>Alcoholism</Value>
</Value>
<Value name="11">
<Value>Handicap</Value>
</Value>
<Value name="12">
<Value>smsReceived</Value>
</Value>
<Value name="13">
<Value>noShow</Value>
</Value>
</Data>
<DataLocation>^poCN.Bwdu.1</DataLocation>
<DefaultData>appointmentsDefaultData</DefaultData>
<ExtentLocation>^poCN.Bwdu</ExtentLocation>
<IdFunction>sequence</IdFunction>
<IdLocation>^poCN.Bwdu.1</IdLocation>
<Index name="IDKEY">
<Location>^poCN.Bwdu.1</Location>
</Index>
<IndexLocation>^poCN.Bwdu.I</IndexLocation>
<StreamLocation>^poCN.Bwdu.S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
