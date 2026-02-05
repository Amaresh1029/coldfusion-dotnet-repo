<form action="" method="post" class="prime-form">
    <input type="text" name="num" placeholder="Enter a number" required>
    <input type="submit" value="Check Prime">
</form>

<style>
    .prime-form {
        background: #f9f9f9;
        padding: 12px;
        border-radius: 6px;
        display: inline-block;
    }

    .prime-form input {
        padding: 6px 8px;
        margin: 4px;
        border: 1px solid #bbb;
        border-radius: 4px;
    }

    .prime-form input[type="submit"] {
        background: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }

    .prime-form input[type="submit"]:hover {
        background: #45a049;
    }

    .box {
        background: #f9f9f9;
        padding: 15px;
        border-radius: 6px;
        border: 1px solid #ccc;
        width: fit-content;
        margin: 20px auto;
        text-align: center;
    }
</style>

<cfif structKeyExists(form, "num")>

    <cfset inputString = trim(form.num)>

    <cfif NOT isNumeric(inputString)>
        <cfset session.prime = inputString & " is not a number">
    <cfelse>
        <cfset n = val(inputString)>
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

        <cfif isPrime>
            <cfset session.prime = n & " is a Prime Number">
        <cfelse>
            <cfset session.prime = n & " is NOT a Prime Number">
        </cfif>
    </cfif>


</cfif>

<cfif structKeyExists(session, "prime")>
    <cfoutput>
        <div class="box">#session.prime#</div>
    </cfoutput>
</cfif>
