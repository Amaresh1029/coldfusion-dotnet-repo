<cfset input = form.nums>
<cfset arr = listToArray(input)>
<cfset n = arrayLen(arr)>

<cfoutput>
<div class="box">
    <h3>Original Values</h3>
    <cfloop from="1" to="#n#" index="i">
        #arr[i]#<br>
    </cfloop>

    <cfloop from="1" to="#n-1#" index="i">
        <cfloop from="1" to="#n-i#" index="j">
            <cfif val(arr[j]) GT val(arr[j+1])>
                <cfset temp = arr[j]>
                <cfset arr[j] = arr[j+1]>
                <cfset arr[j+1] = temp>
            </cfif>
        </cfloop>
    </cfloop>


    <h3>Sorted Values</h3>
    <cfloop from="1" to="#arrayLen(arr)#" index="i">
        #arr[i]#<br>
    </cfloop>

    <a href="../index.cfm">Go to index</a>
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

    h3 {
        margin-bottom: 5px;
    }

    a {
        text-decoration: none;
        color: #0066cc;
    }
</style>
