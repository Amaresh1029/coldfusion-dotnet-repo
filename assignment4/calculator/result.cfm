<cfset num1 = val(form.num1)>
<cfset num2 = val(form.num2)>
<cfset op = form.op>
<cfset result = 0>

<cftry>
<cfswitch expression="#op#">
    <cfcase value="+">
        <cfset result = num1 + num2>
    </cfcase>
    <cfcase value="-">
        <cfset result = num1 - num2>
    </cfcase>
    <cfcase value="/">
        <cfset result = num1 / num2>    
    </cfcase>
    <cfcase value="*">
        <cfset result = num1 * num2>
    </cfcase>
</cfswitch>

<cfoutput>
<div class="center">
    <div class="box">
        <h2>Result</h2>
        <p>#num1# #op# #num2# = <strong>#result#</strong></p>
        <a href="../index.cfm">Go to index</a>
    </div>
</div>
</cfoutput>

<cfcatch>
<div class="center">
    <div class="box error">Invalid expression. Can't divide by 0...
    <a href="../index.cfm">Go to index</a>
    
    </div>
</div>
</cfcatch>
</cftry>

<style>
    .center {
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .box {
        background: #f9f9f9;
        padding: 20px;
        border-radius: 8px;
        border: 1px solid #ccc;
        text-align: center;
    }

    .error {
        color: red;
    }

    a {
        text-decoration: none;
        color: #0066cc;
    }
</style>
