<cfset str = form.str>
<cfset inputString = str>
<cfset rev = "">

<cfset left = 1>
<cfset right = len(str)>

<cfloop condition="left LTE right">    
    <cfset rev &= mid(str, right, 1)>
    <cfset right = right - 1>
</cfloop>

<cfset right = len(str)>
<cfset left = 1>
<cfset isPalindrome = true>

<cfloop condition="left LTE right">
    <cfif mid(str, left, 1) NEQ mid(rev, left, 1)>
        <cfset isPalindrome = false>
        <cfbreak>
    </cfif>
    <cfset left = left + 1>
</cfloop>

<cfoutput>
<div class="box">
    <h2>Palindrome Result</h2>
    <p>
        <cfif !isNumeric(inputString)>
            "#str#" is 
            <strong>#isPalindrome ? "a palindrome" : "not a palindrome"#</strong>
        <cfelse>
            #inputString# is a Number
        </cfif>
    </p>
    <a href="../index.cfm">Go to index</a>
</div>
</cfoutput>

<style>
    .box {
        background: #f9f9f9;
        padding: 15px;
        border-radius: 6px;
        border: 1px solid #ccc;
        width: fit-content;
        margin: 50px auto;
        text-align: center;
    }

    a {
        text-decoration: none;
        color: #0066cc;
    }
</style>
