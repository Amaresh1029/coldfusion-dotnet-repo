<form action="\assignment4\reverseString\result.cfm" method="post" class= "rev-form">
    <input type="text" name="str" placeholder="Enter a string" required>
    <input type="submit" value="reverse">
</form>

<style>
    .rev-form {
        background: #f9f9f9;
        padding: 12px;
        border-radius: 6px;
        display: inline-block;
    }

    .rev-form input {
        padding: 6px 8px;
        margin: 4px;
        border: 1px solid #bbb;
        border-radius: 4px;
    }

    .rev-form input[type="submit"] {
        background: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }

    .rev-form input[type="submit"]:hover {
        background: #45a049;
    }
</style>

