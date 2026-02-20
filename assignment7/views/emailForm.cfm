
<cfset mailObj = createObject("component", "Mail")>


<cfif structKeyExists(form, "submit")>

    <cfset result = mailObj.sendMail(
        form.name,
        form.email,
        form.subject,
        form.message
    )>

</cfif>

<!DOCTYPE html>
<html>
<head>
<title>Send Email</title>

<style>
    body {
        font-family: Arial;
        background: #f4f6f9;
    }

    .container {
        width: 500px;
        margin: 60px auto;
        background: white;
        padding: 30px;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }

    input, textarea {
        width: 100%;
        padding: 8px;
        margin-top: 5px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    button {
        padding: 10px;
        width: 100%;
        background: #007bff;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    button:hover {
        background: #0056b3;
    }

    .result {
        margin-top: 15px;
        padding: 10px;
        background: #f1f1f1;
        border-radius: 5px;
    }
    a   {
        float: right;
    }
</style>
</head>

<body>

<div class="container">

<h2>Send Email</h2>

<form method="post">

    <label>Name:</label>
    <input type="text" name="name" required>

    <label>Your Email:</label>
    <input type="email" name="email" required>

    <label>Subject:</label>
    <input type="text" name="subject" >

    <label>Message:</label>
    <textarea name="message" rows="5" required></textarea>

    <button type="submit" name="submit">Send Email</button>

</form>


<cfif structKeyExists(variables,"result")>
    <div class="result">
        <cfoutput>#result.message#</cfoutput>
    </div>
</cfif>

<br>
<a href="../index.cfm">Back</a>

</div>

</body>
</html>