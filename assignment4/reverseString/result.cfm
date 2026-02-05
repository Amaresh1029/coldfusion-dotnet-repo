<cfset str = form.str>
<cfset rev = "">

<cfset left = 1>
<cfset right = len(str)>

<cfloop condition="left LTE right">    
    <cfset rev &= mid(str, right, 1)>
    <cfset right = right - 1>
</cfloop>

<cfoutput>
<div class="box">
    <cfif not isNumeric(str)>
    <h2>After Reverse</h2>
    <p>#rev#</p>
    <cfelse>
    <h2> #str# is number</h2>
    </cfif>
    <a href="..\index.cfm">Go to index</a>
</div>
</cfoutput>

<style>
    .box {
        margin: 50px auto;
        padding: 15px;
        border: 1px solid #ccc;
        border-radius: 6px;
        width: fit-content;
        text-align: center;
        background: #f9f9f9;
    }

    a {
        text-decoration: none;
        color: #0066cc;
    }
</style>
