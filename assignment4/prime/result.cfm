<cfset n = val(form.num)>
<cfset isPrime = true>

<cfif n LTE 1>
    <cfset isPrime = false>
<cfelse>
    <cfloop from="2" to="#int(sqr(n))#" index="i">
        <cfif n MOD i EQ 0>
            <cfset isPrime = false>
            <cfbreak>
        </cfif>
    </cfloop>
</cfif>

<cfoutput>
<div class="box">
    <cfif isPrime>
        <h2>#n# is a Prime Number</h2>
    <cfelse>
        <h2>#n# is NOT a Prime Number</h2>
    </cfif>

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
