<cfcomponent>

    
    <cffunction name="sendMail" access="public" returntype="struct">
        
        <cfargument name="senderName" required="true">
        <cfargument name="senderEmail" required="true">
        <cfargument name="subject" required="false" default="">
        <cfargument name="message" required="false" default="">

        <cfset var result = structNew()>

        <cfif NOT (len(trim(arguments.senderName)) and 
        reFind("^[A-Za-z ]+$",arguments.senderName))>
            <cfset result.status = "error">
            <cfset result.message =  "Name is incorrect.">
            <cfreturn result>
        </cfif>

        <cftry>

            <cfmail 
                to="solauquammukeu-4918@yopmail.com"
                from="#arguments.senderEmail#"
                subject="#arguments.subject#"
                type="html">

                <h3>New Message From Assignment 7</h3>

                <p><strong>Name:</strong> #arguments.senderName#</p>
                <p><strong>Message:</strong></p>
                <p>#arguments.message#</p>

            </cfmail>

            <cfset result.status = "success">
            <cfset result.message = "Email sent successfully!">

        <cfcatch>

            
            <cflog
                    file="error"
                    text="#now()# , Mail Error , #cfcatch.message#">

            <cfset result.status = "error">
            <cfset result.message = "Error sending email: " & cfcatch.message>

        </cfcatch>
        </cftry>

        <cfreturn result>

    </cffunction>

</cfcomponent>