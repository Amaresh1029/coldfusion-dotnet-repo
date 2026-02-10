<cfquery name="showMembers" datasource="library">
    SELECT * FROM Members ORDER BY date_joined;
</cfquery>

<html>
<head>
    <style>
        body {
            font-family: Arial, sans-serif;
        }

        table {
            border-collapse: collapse;
            width: 70%;
            margin: 40px auto;
        }

        th, td {
            border: 1px solid #aaa;
            padding: 8px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>

<body>
<cfinclude template="header.cfm" >

    <table>
        <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Middle Name</th>
            <th>Last Name</th>
            <th>Date Joined</th>
        </tr>

        <cfoutput query="showMembers">
            <tr>
                <td>#id#</td>
                <td>#first_name#</td>
                <td>#iif(isNull(middle_name), "'---'", "middle_name")#</td>
                <td>#iif(isNull(last_name), "'---'", "last_name")#</td>
                <td>#dateFormat(date_joined, "dd-mmm-yyyy")#</td>
            </tr>
        </cfoutput>
    </table>
</body>
</html>
