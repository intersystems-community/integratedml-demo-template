Class User.MovieData Extends (%Persistent, %XML.Adaptor)
{

Property review As %String(MAXLEN = 32000);

Property sentiment As %Boolean;

Storage Default
{
<Data name="MovieDataDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>review</Value>
</Value>
<Value name="3">
<Value>sentiment</Value>
</Value>
</Data>
<DataLocation>^User.MovieDataD</DataLocation>
<DefaultData>MovieDataDefaultData</DefaultData>
<IdLocation>^User.MovieDataD</IdLocation>
<IndexLocation>^User.MovieDataI</IndexLocation>
<StreamLocation>^User.MovieDataS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
