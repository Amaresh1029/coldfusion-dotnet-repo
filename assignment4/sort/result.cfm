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

    h3 {
        margin-bottom: 5px;
    }

    a {
        text-decoration: none;
        color: #0066cc;
    }
</style>

<cfset input = replace(form.nums, " ", "", "all")>
<cfset arr = listToArray(input)>
<cfset n = arrayLen(arr)>

<cfoutput>
<div class="box">

    
    <h3>Input Values</h3>
    <cfloop from="1" to="#n#" index="i">
        <cfif isNumeric(arr[i])>
            #arr[i]# -> Number<br>
        <cfelse>
            #arr[i]# -> Character<br>
        </cfif>
    </cfloop>

    
    <cfloop from="1" to="#n-1#" index="i">
        <cfloop from="1" to="#n-i#" index="j">
            <cfif asc(arr[j]) GT asc(arr[j+1])>
                <cfset temp = arr[j]>
                <cfset arr[j] = arr[j+1]>
                <cfset arr[j+1] = temp>
            </cfif>
        </cfloop>
    </cfloop>

    <h3>Sorted by ASCII</h3>
    <cfloop from="1" to="#arrayLen(arr)#" index="i">
        #arr[i]#<br>
    </cfloop>

    <a href="../index.cfm">Go to index</a>
</div>
</cfoutput>
