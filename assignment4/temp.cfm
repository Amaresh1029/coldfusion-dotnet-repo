<cfoutput> For loop:</cfoutput>
<cfloop from="2" to="10" step="2" index="i">
    <cfoutput>#i#</br></cfoutput>
</cfloop>

<cfoutput> while loop: </cfoutput>

<cfset i = 2>
<cfloop condition="#i# lte 10">
    <cfoutput> #i#</br></cfoutput>
    <cfset i = i + 2>
</cfloop>

<cfset list1 = "Amaresh!Priya!Nirmal   Umesh!">

<cfloop list="list1" delimiters="!" index="i">
    <cfoutput></br></br></cfoutput>
</cfloop>

<cfset a = 11>
<cfset
<cfif a gt 10>
    <cfoutput></br> #a# is greater than 10</cfoutput>
<cfelseif a gte 1>
    <cfoutput>
            </br>#a# is greater than or equal to 11
        </cfoutput>
    <cfelse>
        <cfoutput></br> #a# is smaller than 10 </cfoutput>
</cfif>