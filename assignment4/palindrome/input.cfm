<form action="\assignment4\palindrome\result.cfm" method="post" class="pal-form">
    <input type="text" name="str" placeholder="Enter a string" required>
    <input type="submit" value="Palindrome">
</form>

<style>
    .pal-form {
        background: #f9f9f9;
        padding: 12px;
        border-radius: 6px;
        display: inline-block;
    }

    .pal-form input {
        padding: 6px 8px;
        margin: 4px;
        border: 1px solid #bbb;
        border-radius: 4px;
    }

    .pal-form input[type="submit"] {
        background: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }

    .pal-form input[type="submit"]:hover {
        background: #45a049;
    }
</style>