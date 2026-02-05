<cfset input1 = form.num1>
<cfset input2 = form.num2>
<cfset num1 = val(input1)>
<cfset num2 = val(input2)>
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
    <cfcase value="%">
        <cfset result = num1 % num2>
    </cfcase>
</cfswitch>

<cfoutput>
<div class="center">
    <div class="box">
        <cfif not isNumeric(input1) or not isNumeric(input2)>
            <h2 class="error"> Enter a valid input</h2>
        <cfelse>
        <h2>Result</h2>
        <p>#num1# #op# #num2# = <strong>#result#</strong></p>
        </cfif>
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

































<form action="" method="post" class="calc-form">
    <input type="text" name="num1" placeholder="Number 1" required>
    <select name="op">
        <option value="+">+</option>
        <option value="-">-</option>
        <option value="*">*</option>
        <option value="/">/</option>
        <option value="%">%</option>
    </select>
    <input type="text" name="num2" placeholder="Number 2" required>
    <input type="submit" value="=">
</form>

<style>
    .calc-form {
        display: flex;
        gap: 10px;
        align-items: center;
    }

    .calc-form input,
    .calc-form select {
        padding: 6px 8px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    .calc-form input[type="submit"] {
        background-color: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }

    .calc-form input[type="submit"]:hover {
        background-color: #45a049;
    }

    .center {
        margin-top: 20px;
        display: flex;
        justify-content: center;
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

<cfif structKeyExists(form, "num1")>

    <cfset input1 = trim(form.num1)>
    <cfset input2 = trim(form.num2)>
    <cfset op = form.op>

    <cfoutput>
    <div class="center">
        <div class="box">

            <cfif NOT isNumeric(input1) OR NOT isNumeric(input2)>
                <h3 class="error">Enter valid numbers</h3>

            <cfelse>
                <cfset num1 = val(input1)>
                <cfset num2 = val(input2)>

                <cfif (op EQ "/" or op eq "%") AND num2 EQ 0>
                    <h3 class="error">Cannot divide by zero</h3>
                <cfelse>

                    <cfset result = 0>
                    <cfswitch expression="#op#">
                        <cfcase value="+"><cfset result = num1 + num2></cfcase>
                        <cfcase value="-"><cfset result = num1 - num2></cfcase>
                        <cfcase value="*"><cfset result = num1 * num2></cfcase>
                        <cfcase value="/"><cfset result = num1 / num2></cfcase>
                        <cfcase value="%"><cfset result = num1 MOD num2></cfcase>
                    </cfswitch>

                    <h3>Result</h3>
                    <p>#num1# #op# #num2# = <strong>#result#</strong></p>

                </cfif>
            </cfif>

            
        </div>
    </div>
    </cfoutput>

</cfif>
